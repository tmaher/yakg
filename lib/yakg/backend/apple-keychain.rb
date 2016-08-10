require 'fiddle'
require 'fiddle/import'

#https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html
module AppleSecKeychain
  extend Fiddle::Importer

  dlload '/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation'
  extern 'void CFRelease(void *)'

  dlload '/System/Library/Frameworks/Security.framework/Security'
  NULL=Fiddle::Pointer.new(0).freeze

  # int is 32-bits, even in macOS 64-bit
  # https://developer.apple.com/library/mac/documentation/Darwin/Conceptual/64bitPorting/transition/transition.html
  TYPEDEFS={
    'CFTypeRef' => 'const void *',
    'CFStringRef' => 'void *',
    'FourCharCode' => 'unsigned int',
    'SecKeychainAttrType' => 'unsigned int',
    'OSStatus' => 'int',
    'UInt32' => 'unsigned int',
    'SecKeychainItemRef' => 'void *',
    'SecKeychainRef' => 'void *'
  }.freeze
  DEFAULT_SERVICE='ruby-yakg-gem'.freeze
  TYPEDEFS.each { |k,v| typealias k, v }


  extern 'OSStatus SecKeychainFindGenericPassword(CFTypeRef, UInt32, const char *, UInt32, const char *, UInt32 *, void **, SecKeychainItemRef *)'

  extern 'OSStatus SecKeychainAddGenericPassword(SecKeychainRef, UInt32, const char *, UInt32, const char *, UInt32, const void *, SecKeychainItemRef *)'

  extern 'OSStatus SecKeychainItemDelete(SecKeychainItemRef)'

  extern 'OSStatus SecKeychainItemFreeContent(void *, void *)'

  extern 'CFStringRef SecCopyErrorMessageString(OSStatus, void *)'
  extern 'OSStatus SecKeychainItemModifyContent(SecKeychainItemRef, const void *, UInt32, const void *)'

  def self.delete_generic_password account, service=DEFAULT_SERVICE
    pw = nil
    pw_length_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
    pw_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    item_ref_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)

    retval = self.SecKeychainFindGenericPassword(NULL,
                                                 service.length, service,
                                                 account.length, account,
                                                 pw_length_ptr, pw_ptr,
                                                 item_ref_ptr)
    return nil unless retval.zero?

    item_deref = item_ref_ptr.to_str.unpack('Q')[0]

    self.SecKeychainItemDelete item_deref
    self.CFRelease item_deref
    Fiddle.free pw_length_ptr.to_i
    self.SecKeychainItemFreeContent(NULL, pw_ptr.to_i)
  end

  def self.find_generic_password account, service=DEFAULT_SERVICE
    pw = nil
    begin
      pw_length_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
      pw_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
      retval = self.SecKeychainFindGenericPassword(NULL,
                                                   service.length, service,
                                                   account.length, account,
                                                   pw_length_ptr, pw_ptr, NULL)
      return pw unless retval.zero?

      pw_length = pw_length_ptr.to_str.unpack('I')[0]
      pw_unpack = pw_ptr.to_str.unpack('Q')[0]
      pw = Fiddle::Pointer.new(pw_unpack, Fiddle::TYPE_VOIDP)
                          .to_s(pw_length)
    ensure
      self.SecKeychainItemFreeContent(NULL, pw_ptr.to_i)
      Fiddle.free pw_length_ptr.to_i
    end

    pw
  end

  def self.add_generic_password pw, account, service=DEFAULT_SERVICE
    pw_length_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
    pw_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    item_ref_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    retval = self.SecKeychainFindGenericPassword(NULL,
                                                 service.length, service,
                                                 account.length, account,
                                                 pw_length_ptr, pw_ptr,
                                                 item_ref_ptr)
    if retval.zero?
      item_deref = item_ref_ptr.to_str.unpack('Q')[0]
      self.SecKeychainItemDelete item_deref
      #self.CFRelease item_deref
    end

    self.SecKeychainItemFreeContent NULL, pw_ptr.to_i
    Fiddle.free pw_length_ptr.to_i

    self.SecKeychainAddGenericPassword(NULL,
                                       service.length, service,
                                       account.length, account,
                                       pw.length, pw, NULL)
    true
  end
end

class Yakg
  module Backend::AppleKeychain
    def get acct, svc
      AppleSecKeychain.find_generic_password acct, svc
    end

    def set acct, value, svc
      AppleSecKeychain.add_generic_password value, acct, svc
    end

    def delete acct, svc
      AppleSecKeychain.delete_generic_password acct, svc
    end
  end
end
