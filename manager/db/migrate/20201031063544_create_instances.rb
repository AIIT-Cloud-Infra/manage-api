class CreateInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :instances do |t|
      t.string :uid, null: false
      t.integer :memory, null: false
      t.integer :cpu, null: false
      t.integer :storage, null: false
      t.string :ip_address, null: true
      t.string :mac_address, null: true
      t.string :status, null: false
      t.references :base_img
      t.references :server
      t.references :user

      t.timestamps
    end
  end
end
