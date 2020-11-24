module Services::Instances
  class Index < ActiveInteraction::Base
    integer :user_id

    def execute
      Instance.where(user_id: user_id)
        .select([:uid, :memory, :cpu, :storage, :ip_address, :mac_address, :status, :created_at, :updated_at])
    end
  end
end