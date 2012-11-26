class Yakg
  require "#{File.dirname __FILE__}/yakg/backend"

  @@DEFAULT_SERVICE_NAME = "ruby-yakg-gem"
  def self.DEFAULT_SERVICE_NAME= x; @@DEFAULT_SERVICE_NAME = x; end
  def self.DEFAULT_SERVICE_NAME ; @@DEFAULT_SERVICE_NAME; end
  
  def self.set acct, value, svc=@@DEFAULT_SERVICE_NAME
  end

  def self.get acct, svc=@@DEFAULT_SERVICE_NAME
    Backend.get acct, svc
  end

  def self.unset acct, svc=@@DEFAULT_SERVICE_NAME
  end

  def self.list svc=@@DEFAULT_SERVICE_NAME
  end
  
end
