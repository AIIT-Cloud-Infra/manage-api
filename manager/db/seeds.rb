# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ベースイメージ登録
BaseImg.create(
  name: 'centos7',
  path: '/home/hmori/base_imgs/kvm_centos7'
)

# サーバー登録
ip_addresses = [
  '192.168.0.12',
  '192.168.0.13',
  '192.168.0.14'
]
ip_addresses.each do |address|
  Server.create(
    ip_address: address,
    memory: 6144,
    cpu: 4,
    storage: 600,
  )
end
