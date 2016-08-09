class Yakg
  #https://developer.apple.com/library/mac/#documentation/security/Reference/keychainservices/Reference/reference.html
  module Backend::AppleKeychain
    require 'fiddle'
    extend Fiddle::Importer

    NULL=Fiddle::Pointer.new(0).freeze
    TYPE_ALIASES={
      'CFTypeRef'           => 'const void *',
      'FourCharCode'        => 'unsigned int',
      'SecKeychainAttrType' => 'unsigned int',
      'OSStatus'            => 'int',
      'UInt32'              => 'unsigned int',
      'SecKeychainItemRef'  => 'void *'
    }.freeze
    TYPE_ALIASES.each { |k,v| typealias k, v }

    extern 'OSStatus SecKeychainFindGenericPassword(CFTypeRef, UInt32, const char *, UInt32, const char *, UInt32 *, void **, SecKeychainItemRef *)'
  end

  def get account, service
    pw_len_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
    pw_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    #item_ref_ptr = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    self.SecKeychainFindGenericPassword(NULL, service.length, service,
                                        account.length, account,
                                        pw_len_ptr, pw_ptr, NULL)

    pw_length = uint32p_to_int(pw_len_ptr)
    pw = voidpp_to_str(pw_ptr, pw_length)
    pw
  end

  def uint32p_to_int ptr
    ptr.to_str.unpack('I')[0]
  end

  def voidpp_to_str ptr, length
    Fiddle::Pointer.new(ptr.to_str.unpack('Q')[0],
                        Fiddle::TYPE_VOIDP).to_s(length)
  end
end
