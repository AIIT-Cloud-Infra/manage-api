module Services::Instances
  class Destroy < ActiveInteraction::Base
    integer :user_id
    string :instance_uid

    def execute
      instance = Instance.eager_load(:server).find_by!(user_id: user_id, uid: instance_uid)
      ip = instance.server.ip_address

      ActiveRecord::Base.transaction do
        instance.save!(status: Instance.statuses[:terminating])
        
        client = Faraday.new(url: "http://#{instance.server.ip_address}")
        res = client.post do |req|
          req.url = "/instances/#{instance.uid}/terminate"
        end
        unless res.success?
          raise IOError
        end
      end
    end
  end
end