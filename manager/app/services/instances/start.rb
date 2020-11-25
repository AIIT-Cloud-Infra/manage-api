require "faraday"

module Services::Instances
  class Start < ActiveInteraction::Base
    integer :user_id
    string :id

    def execute
      instance = Instance.eager_load(:server).find_by!(user_id: user_id, uid: id)

      ActiveRecord::Base.transaction do
        instance.save!(status: Instance.statuses[:starting])

        client = Faraday.new(url: "http://#{instance.server.ip_address}/instances/#{instance.uid}/start")
        res = client.post do |req|
        end
        unless res.success?
          raise IOError
        end
      end
    end
  end
end