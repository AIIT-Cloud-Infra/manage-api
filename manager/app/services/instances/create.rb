require "faraday"

module Services::Instances
  class Create < ActiveInteraction::Base
    integer :user_id
    string :base_img
    integer :memory
    integer :cpu

    def execute
      img = BaseImg.find_by!(name: base_img)

      # サーバー選択
      server = select_physical_server(memory, cpu, img.size)
      # uid生成
      uid = SecureRandom.uuid
      ActiveRecord::Base.transaction do
        instance = Instance.create!(
          uid: uid,
          memory: memory,
          cpu: cpu,
          storage: img.size,
          user_id: user_id,
          base_img_id: img.id,
          server_id: server.id,
          status: Instance.statuses[:starting]
        )

        client = Faraday.new(url: "http://#{server.ip_address}/instances")
        res = client.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = {
            uid: uid,
            memory: memory,
            cpu: cpu
          }.to_json
        end
        unless res.success?
          raise IOError
        end
        { instance_uid: uid }
      end
    end

    private

    # 物理サーバーの選択ロジック
    def select_physical_server(memory, cpu, storage)
      servers = Server.availables(memory, cpu, storage)
      # この時点で物理サーバーが存在しない場合は、VM作成不可
      if servers.length == 0
        raise ActiveRecord::RecordNotSaved, 'resource unavailable. not enough server capacity.'
      end
      # 1つの場合は無条件で選択
      if servers.length == 1
        return servers[0]
      end

      # サーバー毎の空き領域の大きさを計算
      diff = []
      servers.each do |server|
        cpu = server[:rest_cpu] * 1000 # メモリーの重要度と揃える
        memory = server[:rest_memory]
        storage = server[:rest_storage] # CPUとメモリーよりは重要度が低いのでそのまま
        total = (cpu + memory + storage)
        diff << total
      end
      # 空き領域が最大のサーバーを選択。空き領域が同じであれば配列インデックス順
      return servers[diff.index(diff.max)]
    end
  end
end