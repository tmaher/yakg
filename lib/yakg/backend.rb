# https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html
require "ffi"
require "corefoundation"

class Yakg
  module Backend
    #require "dl/import"
    #extend DL::Importer

    #dlload "/System/Library/Frameworks/Security.framework/Versions/A/Security"

    #typealias "CFTypeRef", "const void *"
    #typealias "OSStatus", "int"
    #typealias "UInt32", "unsigned int"
    
    #extern "OSStatus SecKeychainFindGenericPassword(CFTypeRef, UInt32, const char *, UInt32, const char *, UInt32 *, void **, void *)"

    def self.framework name
      "/System/Library/Frameworks/#{name}.framework/#{name}"
    end

    class KeychainError < Exception
    end

    extend FFI::Library
    NULL = FFI::Pointer::NULL
    ffi_lib(FFI::Library::LIBC,
            framework(:CoreFoundation),
            framework(:Security))

    attach_function :malloc, [:size_t], :pointer
    attach_function :free, [:pointer], :void
    attach_function :CFRelease, [:pointer], :void

    attach_function(:SecKeychainItemFreeContent,
                    [:pointer, :pointer], :uint32)

    attach_function(:SecKeychainFindGenericPassword,
                    [:pointer, :uint32, :string, :uint32, :string,
                     :pointer, :pointer, :pointer],
                    :uint32)

    attach_function(:SecKeychainAddGenericPassword,
                    [:pointer, :uint32, :string, :uint32, :string,
                     :uint32, :pointer, :pointer],
                    :uint32)

    attach_function(:SecKeychainItemDelete, [:pointer], :uint32)
    attach_function(:SecCopyErrorMessageString, [:uint32, :pointer],
                    :pointer)

    attach_function(:SecKeychainItemModifyContent,
                    [:pointer, :pointer, :uint32, :string], :uint32)

    attach_function(:SecKeychainSearchCreateFromAttributes,
                    [:pointer, :string, :pointer, :pointer], :uint32)

    def self.error_message code
      CF::String.new(SecCopyErrorMessageString(code, NULL)).to_s
    end

    def self.raise_error? code
      raise KeychainError.new(error_message code) if code != 0
      code
    end
    
    def self.delete acct, svc
      pw_length = FFI::MemoryPointer.new :uint32
      pw_val = FFI::MemoryPointer.new :pointer
      item_ref = FFI::MemoryPointer.new :pointer
      raise_error? SecKeychainFindGenericPassword(NULL, svc.length, svc,
                                                  acct.length, acct,
                                                  pw_length, pw_val,
                                                  item_ref)
      raise_error? SecKeychainItemFreeContent(NULL, pw_val.read_pointer)
      raise_error? SecKeychainItemDelete(item_ref.read_pointer)
      CFRelease item_ref.read_pointer
      true
    end

    def self.get acct, svc
      pw_length = FFI::MemoryPointer.new :uint32
      pw_val = FFI::MemoryPointer.new :pointer
      retval = SecKeychainFindGenericPassword(NULL, svc.length, svc,
                                              acct.length, acct,
                                              pw_length, pw_val, NULL)
      return nil unless 0 == retval
      pw = pw_val.read_pointer.read_string(pw_length.read_int)
      retval = SecKeychainItemFreeContent(NULL, pw_val.read_pointer)
      return nil unless 0 == retval

      pw
    end

    def self.set acct, value, svc
      pw_length = FFI::MemoryPointer.new :uint32
      pw_val = FFI::MemoryPointer.new :pointer
      item_ref = FFI::MemoryPointer.new :pointer
      retval = SecKeychainFindGenericPassword(NULL, svc.length, svc,
                                              acct.length, acct,
                                              pw_length, pw_val, item_ref)
      if retval != 0
        raise_error? SecKeychainAddGenericPassword(NULL, svc.length, svc,
                                                   acct.length, acct,
                                                   value.length, value, NULL)
      else
        raise_error? SecKeychainItemFreeContent(NULL, pw_val.read_pointer)
        raise_error? SecKeychainItemModifyContent(item_ref.read_pointer, NULL,
                                                  value.length, value)
        CFRelease item_ref.read_pointer
      end
      true
    end
    
  end
end
