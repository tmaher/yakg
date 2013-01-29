class Yakg
  module Backend
    if RUBY_PLATFORM.match("-darwin")
      require "yakg/backend/macos-keychain"
      extend Yakg::Backend::MacosKeychain
    else
      require "yakg/backend/netrc-fallback"
      extend Yakg::Backend::NetrcFallback
    end
  end
end
