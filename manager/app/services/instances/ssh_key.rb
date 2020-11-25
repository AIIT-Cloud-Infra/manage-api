module Services::Instances
  class SshKey < ActiveInteraction::Base
    integer :user_id
    string :id

    def execute
      instance = Instance.eager_load(:ssh_key).find_by!(user_id: user_id, uid: id)
      instance.ssh_key
    end
  end
end