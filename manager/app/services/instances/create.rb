module Services::Instances
  class Create < ActiveInteraction::Base
    integer :user_id
    string :base_img
    integer :momory
    integer :cpu

    def execute
      img = BaseImg.find_by!(name: base_img)

      # TODO: サーバー選択ロジック
      Instance.create!(
        uid: nil, # TODO
        memory: momory,
        cpu: cpu,
        user_id: user_id,
        base_img_id: img.id,
        server_id: nil, # TODO
        status: Instance.statuses[:starting]
      )
    end
  end
end