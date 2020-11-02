module Services::Instances
  class Stop < ActiveInteraction::Base
    integer :user_id
    string :instance_uid

    def execute
      instance = Instance.eager_load(:server).find_by!(user_id: user_id, uid: instance_uid)
      ip = instance.server.ip_address

      ActiveRecord::Base.transaction do
        instance.save!(status: Instance.statuses[:halting])
        # TODO: サーバーとの通信処理
      end
    end
  end
end