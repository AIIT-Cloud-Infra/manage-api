# ベースイメージ登録
BaseImg.create!(
  name: 'centos7',
  size: 8,
  path: '/home/hmori/base_imgs/kvm_centos7'
)

# サーバー登録
ip_addresses = [
  '192.168.0.12',
  '192.168.0.13',
  '192.168.0.14'
]
ip_addresses.each do |address|
  Server.create!(
    ip_address: address,
    memory: 6144,
    cpu: 4,
    storage: 600,
  )
end
