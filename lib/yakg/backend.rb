# https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html

require "ffi"

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

    attach_function(:CFStringGetLength, [:pointer], :int64)
    attach_function(:CFStringGetCString,
                    [:pointer, :pointer, :long, :uint32], :bool)

    def self.error_message code
      msg_cf_ref = SecCopyErrorMessageString(code, NULL)
      #return msg_cf_ref.methods
      #CFStringGetLength(msg_cf_ref)
      #return msg_cf_ref.read_pointer.to_i

      # utf-8 chars are guaranteed to be <= 4 bytes
      # 0x08000100 is the apple magic number for UTF-8 encoding
      c_buffer = malloc(400)
      CFStringGetCString(msg_cf_ref.read_pointer,
                         c_buffer.read_pointer,
                         400, 0x08000100)
      retstring = c_buffer.read_string
      free c_buffer.read_pointer
      retstring
    end
    
    def self.delete acct, svc
      pw_length = FFI::MemoryPointer.new :uint32
      pw_val = FFI::MemoryPointer.new :pointer
      item_ref = FFI::MemoryPointer.new :pointer
      retval = SecKeychainFindGenericPassword(NULL, svc.length, svc,
                                              acct.length, acct,
                                              pw_length, pw_val,
                                              item_ref)
      SecKeychainItemFreeContent(NULL, pw_val.read_pointer)
      SecKeychainItemDelete(item_ref.read_pointer)
      puts error_message(-25294)
      CFRelease item_ref.read_pointer
    end

    def self.get acct, svc
      pw_length = FFI::MemoryPointer.new :uint32
      pw_val = FFI::MemoryPointer.new :pointer
      retval = SecKeychainFindGenericPassword(NULL, svc.length, svc,
                                              acct.length, acct,
                                              pw_length, pw_val, NULL)
      return nil unless retval == 0
      pw = pw_val.read_pointer.read_string(pw_length.read_int)
      reval = SecKeychainItemFreeContent(NULL, pw_val.read_pointer)
      return nil unless retval == 0
      pw
    end

    def self.set acct, value, svc
      SecKeychainAddGenericPassword(NULL, svc.length, svc,
                                    acct.length, acct,
                                    value.length, value, NULL)
    end

    
  end
end
