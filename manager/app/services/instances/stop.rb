module Services::Instances
  class Stop < ActiveInteraction::Base
    integer :user_id
    string :instance_uid

    def execute
      instance = Instance.eager_load(:server).find_by!(user_id: user_id, uid: instance_uid)

      ActiveRecord::Base.transaction do
        instance.save!(status: Instance.statuses[:halting])

        client = Faraday.new(url: "http://#{instance.server.ip_address}")
        res = client.post do |req|
          req.url = "/instances/#{instance.uid}/stop"
        end
        unless res.success?
          raise IOError
        end
      end
    end
  end
end