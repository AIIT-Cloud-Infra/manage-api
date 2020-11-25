require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

require 'sidekiq'
require 'active_record'
require 'mysql2'

require './models/instance'
require './models/ssh_key'
require './models/base_img'
require './create_instance_worker'

# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(development? ? :development : :production)
# Sidekiq Redis
Sidekiq.configure_client do |config|
  config.redis = { 'db' => 1 }
end

set :bind, '0.0.0.0'
set :port, 80

# VMの作成
post '/instances' do
  # キューイングで実行
  CreateInstanceWorker.perform_async(JSON.parse(request.body.read))
end

# VMの削除
delete '/instances/:uid' do
  uid = params[:uid]
  # DBデータ
  instance = Instance.find_by!(uid: uid)
  # 削除中ステータス
  instance.update!(
    status: Instance.statuses[:terminating]
  )
  # 停止処理
  %x(sh ./scripts/destroy_instance.sh #{uid})
  # ステータス更新
  instance.update!(
    status: Instance.statuses[:terminated]
  )
end

# VMの起動
post '/instances/:uid/start' do
  uid = params[:uid]
  # DBデータ
  instance = Instance.find_by!(uid: uid)
  # 起動処理
  %x(sh ./scripts/start_instance.sh #{uid})
  # ステータス更新
  instance.update!(
    status: Instance.statuses[:running]
  )
end

# VMの停止
post '/instances/:uid/stop' do
  uid = params[:uid]
  # DBデータ
  instance = Instance.find_by!(uid: uid)
  # 停止中ステータス
  instance.update!(
    status: Instance.statuses[:halting]
  )
  # 停止処理
  %x(sh ./scripts/shutdown_instance.sh #{uid})
  # ステータス更新
  instance.update!(
    status: Instance.statuses[:halted]
  )
end
