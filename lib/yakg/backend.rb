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
                    [:pointer, :uint32, :pointer, :pointer], :uint32)
    attach_function(:SecKeychainSearchCopyNext,
                    [:pointer, :pointer], :uint32)
    attach_function(:SecKeychainItemCopyAttributesAndData,
                    [:pointer, :pointer, :pointer, :pointer,
                     :pointer, :pointer], :uint32)
    attach_function(:SecKeychainItemFreeAttributesAndData,
                    [:pointer, :pointer], :uint32)

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

    class SecKeychainAttributeList < FFI::Struct
      layout(:count, :uint32,
             :attr, :pointer)
    end

    def self.s2i s
      s.unpack("N")[0].to_i
    end
    
    enum :SecItemAttr, [:kSecCreatiofnDateItemAttr, s2i('cdat'),
                        :kSecModDateItemAttr, s2i('mdat'),
                        :kSecDescriptionItemAttr, s2i('desc'),
                        :kSecCommentItemAttr, s2i('icmt'),
                        :kSecCreatorItemAttr, s2i('crtr'),
                        :kSecTypeItemAttr, s2i('type'),
                        :kSecScriptCodeItemAttr, s2i('scrp'),
                        :kSecLabelItemAttr, s2i('labl'),
                        :kSecInvisibleItemAttr, s2i('invi'),
                        :kSecNegativeItemAttr, s2i('nega'),
                        :kSecCustomIconItemAttr, s2i('cusi'),
                        :kSecAccountItemAttr, s2i('acct'),
                        :kSecServiceItemAttr, s2i('svce'),
                        :kSecGenericItemAttr, s2i('gena'),
                        :kSecSecurityDomainItemAttr, s2i('sdmn'),
                        :kSecServerItemAttr, s2i('srvr'),
                        :kSecAuthenticationTypeItemAttr, s2i('atyp'),
                        :kSecPortItemAttr, s2i('port'),
                        :kSecPathItemAttr, s2i('path'),
                        :kSecVolumeItemAttr, s2i('vlme'),
                        :kSecAddressItemAttr, s2i('addr'),
                        :kSecSignatureItemAttr, s2i('ssig'),
                        :kSecProtocolItemAttr, s2i('ptcl'),
                        :kSecCertificateType, s2i('ctyp'),
                        :kSecCertificateEncoding, s2i('cenc'),
                        :kSecCrlType, s2i('crtp'),
                        :kSecCrlEncoding, s2i('crnc'),
                        :kSecAlias, s2i('alis')
                       ]
    
    class SecKeychainAttribute < FFI::Struct
      layout(:tag, :SecItemAttr,
             :length, :uint32,
             :data, :pointer)
    end

    class SecKeychainAttributeInfo < FFI::Struct
      layout(:count, :uint32,
             :tag, :pointer,
             :format, :pointer)
    end

    
    def self.list svc
      search_ref = FFI::MemoryPointer.new :pointer
      found_item = FFI::MemoryPointer.new :pointer
      found_attr_list = FFI::MemoryPointer.new :pointer
      svc_attr = SecKeychainAttribute.new

      acct_info = SecKeychainAttributeInfo.new
      acct_info[:count] = 1
      acct_info[:tag] = FFI::MemoryPointer.new :uint32
      acct_info[:tag].write_array_of_int [s2i("acct")]
      acct_info[:format] = FFI::MemoryPointer.new :uint32
      acct_info[:format].write_array_of_int [0]
      
      #attr[:tag] = 1633903476

      svc_attr[:tag] = s2i "svce"
      svc_attr[:length] = svc.length
      svc_attr[:data] = FFI::MemoryPointer.from_string(svc)

      search_attr_list = SecKeychainAttributeList.new
      search_attr_list[:count] = 1
      search_attr_list[:attr] = svc_attr.pointer
      
      #raise "#{"acct".unpack("N")[0].to_i} vs 1633903476"
      #raise "#{"genp".unpack("N")[0].to_i} vs 1734700656"
      # raise "#{s2i "svce"} vs 1937138533"
      
      raise_error? SecKeychainSearchCreateFromAttributes(NULL,
                                                         s2i("genp"),
                                                         search_attr_list,
                                                         search_ref)

      i = 0
      acct_names = []
      while i < 5000 do
        retval = SecKeychainSearchCopyNext(search_ref.read_pointer,
                                           found_item)
        # the magic "no more items" number
        break if retval == 4294941996
        raise_error? retval

        raise_error? SecKeychainItemCopyAttributesAndData(found_item.read_pointer,
                                                          acct_info,
                                                          NULL,
                                                          found_attr_list,
                                                          NULL, NULL)
        f = SecKeychainAttributeList.new found_attr_list.read_pointer
        next if f[:count] != 1

        a = SecKeychainAttribute.new f[:attr]
        next if a[:tag] != :kSecAccountItemAttr

        acct_names.push a[:data].get_string(0, a[:length])
        
        i += 1
      end

      raise_error? SecKeychainItemFreeAttributesAndData(found_attr_list.read_pointer,
                                                        NULL)
      CFRelease search_ref.read_pointer
      
      acct_names
    end
    
  end
end
