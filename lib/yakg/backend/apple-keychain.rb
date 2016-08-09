require 'fiddle'
require 'fiddle/import'

#https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html
module AppleSecKeychain
  extend Fiddle::Importer
  dlload '/System/Library/Frameworks/Security.framework/Security'
  NULL=Fiddle::Pointer.new(0).freeze

  # int is 32-bits, even in macOS 64-bit
  # https://developer.apple.com/library/mac/documentation/Darwin/Conceptual/64bitPorting/transition/transition.html
  TYPEDEFS={
    'CFTypeRef' => 'const void *',
    'FourCharCode' => 'unsigned int',
    'SecKeychainAttrType' => 'unsigned int',
    'OSStatus' => 'int',
    'UInt32' => 'unsigned int',
    'SecKeychainItemRef' => 'void *'
  }.freeze
  DEFAULT_SERVICE='ruby-yakg-gem'.freeze
  TYPEDEFS.each { |k,v| typealias k, v }
  extern 'OSStatus SecKeychainFindGenericPassword(CFTypeRef, UInt32, const char *, UInt32, const char *, UInt32 *, void **, SecKeychainItemRef *)'
  extern 'OSStatus SecKeychainItemFreeContent(void *, void *)'


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

  def self.add_generic_password value, account, service=DEFAULT_SERVICE
    nil
  end
  def self.delete account, service=DEFAULT_SERVICE
    nil
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
      AppleSecKeychain.delete acct, svc
    end
  end
end
