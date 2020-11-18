module Services::Instances
  class Create < ActiveInteraction::Base
    integer :user_id
    string :base_img
    integer :memory
    integer :cpu

    def execute
      img = BaseImg.find_by!(name: base_img)
      uid = SecureRandom.uuid

      # TODO: サーバー選択ロジック
      server = nil
      ActiveRecord::Base.transaction do
        instance = Instance.create!(
          uid: uid,
          memory: memory,
          cpu: cpu,
          user_id: user_id,
          base_img_id: img.id,
          server_id: server.id,
          status: Instance.statuses[:starting]
        )

        client = Faraday.new(url: "http://#{server.ip_address}")
        res = client.post do |req|
          req.url = "/instances"
          req.headers['Content-Type'] = 'application/json'
          req.body = {
            uid: uid,
            memory: memory,
            cpu: cpu
          }.to_json
        end
        unless res.success?
          raise IOError
        end
        { instance_uid: uid }
      end
    end
  end
end