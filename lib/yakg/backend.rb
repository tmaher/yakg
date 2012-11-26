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
    extend FFI::Library
    framework_dir = "/System/Library/Frameworks"
    ffi_lib(FFI::Library::LIBC,
            "#{framework_dir}/Security.framework/Versions/A/Security",
            "/usr/lib/libm.dylib")
    NULL = FFI::Pointer::NULL
    attach_function :malloc, [:size_t], :pointer
    attach_function :free, [:pointer], :void

    attach_function(:SecKeychainItemFreeContent,
                    [:pointer, :pointer], :uint32)

    attach_function(:SecKeychainFindGenericPassword,
                    [:pointer, :uint32, :string, :uint32, :string,
                     :pointer, :pointer, :pointer],
                    :uint32)

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
      
    end
    
  end
end
