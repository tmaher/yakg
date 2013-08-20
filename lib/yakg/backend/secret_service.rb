require "secret_service"

class Yakg
module Backend
module SecretService
  SS = SecretService.new

  def set acct, value, svc
    SS.collection(fix_svc_name svc).create_item(acct, value, nil, true)
  end

  def get acct, svc
    SS.collection(fix_svc_name svc).get_secret acct
  end

  def delete acct, svc
    SS.collection(fix_svc_name svc).get_item(acct).delete
  end

  def list svc
    SS.collection(fix_svc_name svc).all_items.map {|i|
      i.get_property "Label"
    }
  end

  def fix_svc_name n=nil
    (n == Yakg.DEFAULT_SERVICE_NAME) ? SecretService::DEFAULT_COLLECTION : n
  end
  
end
end
end
