class Yakg
  module Backend
    if RUBY_PLATFORM.match("-darwin")
      require "yakg/backend/macos-keychain"
      extend Yakg::Backend::MacosKeychain
    elsif RUBY_PLATFORM.match("win32")
      require "yakg/backend/win32-dpapi"
      extend Yakg::Backend::Win32DPAPI
    else
      require "yakg/backend/netrc-fallback"
      extend Yakg::Backend::NetrcFallback
    end
  end
end
