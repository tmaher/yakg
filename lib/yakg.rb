class Yakg

  @@DEFAULT_SERVICE_NAME = "ruby-yakg-gem"
  def self.DEFAULT_SERVICE_NAME= x; @@DEFAULT_SERVICE_NAME = x; end
  def self.DEFAULT_SERVICE_NAME ; @@DEFAULT_SERVICE_NAME; end
  
  def self.set acct, svc=@@DEFAULT_SERVICE_NAME
  end

  def self.get acct, svc=@@DEFAULT_SERVICE_NAME
  end

  def self.unset acct, svc=@@DEFAULT_SERVICE_NAME
  end

  def self.list svc=@@DEFAULT_SERVICE_NAME
  end
  
end
