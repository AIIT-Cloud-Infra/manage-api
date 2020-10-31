class CreateServers < ActiveRecord::Migration[6.0]
  def change
    create_table :servers do |t|
      t.string :ip_address
      t.integer :memory
      t.integer :cpu
      t.integer :storage

      t.timestamps
    end
  end
end
