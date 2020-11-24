module Services::Instances
  class Show < ActiveInteraction::Base
    integer :user_id
    string :instance_uid

    def execute
      Instance.find_by!(user_id: user_id, uid: instance_uid)
        .select([:uid, :memory, :cpu, :storage, :ip_address, :mac_address, :status, :created_at, :updated_at])
    end
  end
end