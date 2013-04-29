require "ffi"
require "win32/registry"

class Yakg
  module Backend
    module Win32DPAPI

      REG_KEY_PREFIX="Software\\Yakg\\"
      
      def set acct, value, svc
        Win32::Registry::HKEY_CURRENT_USER.create("#{REG_KEY_PREFIX}\\#{svc}") do |reg|
          reg.write_bin acct, DPAPI.encrypt(value).data
        end
      end

      def get acct, svc
        Win32::Registry::HKEY_CURRENT_USER.open("#{REG_KEY_PREFIX}\\#{svc}") do |reg|
          DPAPI.decrypt(reg.read_bin acct)
        end
      end

      def unset acct, svc
        Win32::Registry::HKEY_CURRENT_USER.delete_key "#{REG_KEY_PREFIX}\\#{svc}\\#{acct}"
      end

      def list svc
        Win32::Registry::HKEY_CURRENT_USER.open("#{REG_KEY_PREFIX}\\#{svc}").keys
      end


      # Minimal wrapper around Microsoft's DPAPI
      #
      # struct & function definitions cribbed from...
      # http://msdn.microsoft.com/en-us/library/ms995355.aspx
      module DPAPI
        extend FFI::Library
        ffi_lib 'crypt32'

        class EncryptError < StandardError; end
        class DecryptError < StandardError; end
        
=begin
        typedef struct _CRYPTOAPI_BLOB {
            DWORD cbData;
            BYTE  *pbData;
          } DATA_BLOB;
=end

        class DataBlob < FFI::Struct
          layout :cbData, :uint32,
          :pbData, :pointer

          def initialize blob=nil
            super nil
            self.data = blob unless blob.nil?
          end
          
          def data
            self[:pbData].get_bytes(0, self[:cbData])
          end

          def data= blob
            self[:pbData] = FFI::MemoryPointer.from_string blob
            self[:cbData] = blob.bytesize
          end

        end

        # http://www.pinvoke.net/default.aspx/Enums/CryptProtectFlags.html
        # dwFlags is a bitvector with the following values...
        UI_FORBIDDEN = 0x1
        LOCAL_MACHINE = 0x4
        CRED_SYNC = 0x8
        AUDIT = 0x10
        NO_RECOVERY = 0x20
        VERIFY_PROTECTION = 0x40
        
=begin
      BOOL WINAPI CryptProtectData(
                     _In_      DATA_BLOB *pDataIn,
                     _In_      LPCWSTR szDataDescr,
                     _In_      DATA_BLOB *pOptionalEntropy,
                     _In_      PVOID pvReserved,
                     _In_opt_  CRYPTPROTECT_PROMPTSTRUCT *pPromptStruct,
                     _In_      DWORD dwFlags,
                     _Out_     DATA_BLOB *pDataOut
       );
=end
        
        attach_function :CryptProtectData,
        [:pointer, :string, :pointer, :pointer, :pointer, :uint32, :pointer],
        :int32

        def encrypt plaintext, entropy=nil, flags = []
          ciphertext_blob = DataBlob.new

          desc = nil
          if(plaintext.class == "String") and plaintext.respond_to? "encoding"
            desc = FFI::MemoryPointer.from_string(plaintext.encoding.to_s)
          end
          
          CryptProtectData(DataBlob.new plaintext,
                           desc,
                           entropy.nil? ? nil : DataBlob.new(entropy),
                           nil,
                           nil,
                           flags.reduce(0, :|)
                           ciphertext_blob) or
            raise EncryptErorr
          
          ciphertext_blob.data
        end
        
=begin
      BOOL WINAPI CryptUnprotectData(
                     _In_        DATA_BLOB *pDataIn,
                     _Out_opt_   LPWSTR *ppszDataDescr,
                     _In_opt_    DATA_BLOB *pOptionalEntropy,
                     _Reserved_  PVOID pvReserved,
                     _In_opt_    CRYPTPROTECT_PROMPTSTRUCT *pPromptStruct,
                     _In_        DWORD dwFlags,
                     _Out_       DATA_BLOB *pDataOut
      );
=end
        attach_function :CryptUnprotectData,
        [:pointer, :pointer, :pointer, :pointer, :pointer, :uint32, :pointer],
        :int32

        def decrypt ciphertext, entropy=nil, flags=[]
          plaintext_blob  = DataBlob.new
          desc = FFI::MemoryPointer.new(:pointer, 256)

          CryptUnprotectData(DataBlob.new ciphertext,
                             desc,
                             DataBlob.new entropy,
                             nil,
                             nil,
                             flags.reduce(0, :|),
                             plaintext_blob) or
            raise DecryptError

          encoding = desc.read_pointer.nil? ? 'BINARY' : desc.read_pointer.read_string

          plaintext_blob.data.force_encoding encoding
        end

      end
    end
  end
end
