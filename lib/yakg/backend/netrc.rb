require "netrc"

class Yakg
  module Backend
    module Netrc

      def set acct, value, svc
        n = Netrc.read
        n["#{svc}/#{acct}"] = [acct, value]
        n.save
        acct
      end

      def get acct, svc
        n = Netrc.read
        if n["#{svc}/#{acct}"].nil?
          nil
        else
          n["#{svc}/#{acct}"][1]
        end
      end

      def delete acct, svc
        n = Netrc.read
        n.delete "#{svc}/#{acct}"
        n.save
        true
      end

      def list svc
        known = []
        Netrc.read.each do |x|
          next unless x[1].match /^#{svc}/
          known.push(x[1].sub(/^#{svc}\//, ""))
        end
        known
      end
    
    end
  end
end
