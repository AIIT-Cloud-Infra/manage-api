require 'sidekiq'

require 'active_record'

require './models/instance'
require './models/ssh_key'

Sidekiq.configure_server do |config|
  config.redis = { 'db' => 1 }
end

class CreateInstanceWorker
  include Sidekiq::Worker

  def perform(params)
    uid = params["uid"]
    memory = params["memory"]
    cpu = params["cpu"]
    # DBデータ
    instance = Instance.find_by!(uid: uid)
  
    # VM作成処理
    mac_address = %x(sh ./scripts/create_kvm_machine.sh #{uid} #{memory} #{cpu})
    p mac_address
    # 初期化中ステータス更新
    instance.update!(
      status: Instance.statuses[:initializing]
    )
  
    # 起動待ちでIP取得
    ip_address = %x(sh ./scripts/obtain_ip_address.sh #{mac_address})
    p ip_address
    # SSHキーの作成
    private_key = %x(sh ./scripts/setup_ssh_key.sh #{uid} #{ip_address})
    p private_key
  
    # 必要データの更新
    ActiveRecord::Base.transaction do
      instance.update!(
        mac_address: mac_address,
        ip_address: ip_address,
        status: Instance.statuses[:running]
      )
      SshKey.create!(
        instance: instance,
        value: private_key
      )
    end
  end
end
