require "faraday"

module Services::Instances
  class Destroy < ActiveInteraction::Base
    integer :user_id
    string :id

    def execute
      instance = Instance.eager_load(:server).find_by!(user_id: user_id, uid: id)
      ip = instance.server.ip_address

      ActiveRecord::Base.transaction do
        instance.save!(status: Instance.statuses[:terminating])
        
        client = Faraday.new(url: "http://#{instance.server.ip_address}/instances/#{instance.uid}")
        res = client.delete do |req|
        end
        unless res.success?
          raise IOError
        end
      end
    end
  end
end