class Yakg
  module Backend
    if RUBY_PLATFORM.match("-darwin")
      require "yakg/backend/macos-keychain"
      extend Yakg::Backend::MacosKeychain
    elsif RUBY_PLATFORM.match("win32")
      require "yakg/backend/win32-dpapi"
      extend Yakg::Backend::Win32DPAPI
    else
      begin
        require 'dbus'
        DBus::SystemBus.instance
        require "yakg/backend/secret_service"
        extend Yakg::Backend::SecretService
      rescue
        require "yakg/backend/netrc"
        extend Yakg::Backend::Netrc
      end
    end
  end
end
