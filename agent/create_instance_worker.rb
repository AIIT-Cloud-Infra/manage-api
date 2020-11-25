require 'sidekiq'

require 'active_record'

require './models/instance'
require './models/ssh_key'

class CreateInstanceWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(uid, params = {})
    memory = params["memory"]
    cpu = params["cpu"]
    # DBデータ
    instance = Instance.find_by!(uid: uid)
  
    # VM作成処理
    mac_address = %x(sh ./scripts/create_kvm_machine.sh #{uid} #{memory} #{cpu})
    mac_address = mac_address.strip 
    # 初期化中ステータス更新
    instance.update!(
      status: Instance.statuses[:initializing]
    )
  
    # 起動待ちでIP取得
    ip_address = %x(sh ./scripts/obtain_ip_address.sh #{mac_address})
    ip_address = ip_address.strip
    # SSHキーの作成
    private_key = %x(sh ./scripts/setup_ssh_key.sh #{uid} #{ip_address})
    private_key = private_key.strip
  
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
