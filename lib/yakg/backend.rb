# https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html

class Yakg
  module Backend
    require "dl/import"
    extend DL::Importer

    dlload "/System/Library/Frameworks/Security.framework/Versions/A/Security"

    typealias "CFTypeRef", "const void *"
    typealias "OSStatus", "int"
    typealias "UInt32", "unsigned int"
    
    extern "OSStatus SecKeychainFindGenericPassword(CFTypeRef, UInt32, const char *, UInt32, const char *, UInt32 *, void **, void *)"
    
    def self.get acct, svc
      pw_length = DL::CPtr.new DL::NULL
      pw = DL::CPtr.new DL::NULL
      
      retval = SecKeychainFindGenericPassword DL::NULL, svc.length, svc,
      acct.length, acct, pw_length.ptr, pw.ptr, DL::NULL
      pw
    end
    
  end
end
