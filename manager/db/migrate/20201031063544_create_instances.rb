class CreateInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :instances do |t|
      t.string :uid
      t.integer :memory
      t.integer :cpu
      t.string :ip_address
      t.string :mac_address
      t.string :status
      t.references :base_img
      t.references :server
      t.references :user

      t.timestamps
    end
  end
end
