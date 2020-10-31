require 'sinatra'
require 'sinatra/reloader' if development?

set :bind, '0.0.0.0'

# 全VM情報の取得
get '/instances' do
  "全VM情報の取得: 未実装"
end

# VMの作成
post '/instances' do
  "VMの作成: 未実装"
end

# VM情報の取得
get '/instances/:id' do
  "VM情報の取得: 未実装"
end

# VMの削除
delete '/instances/:id' do
  "VMの削除: 未実装"
end

# VMの起動
post '/instances/:id/start' do
  "VMの起動: 未実装"
end

# VMの停止
post '/instances/:id/stop' do
  "VMの停止: 未実装"
end
