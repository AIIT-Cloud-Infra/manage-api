class CreateBaseImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :base_imgs do |t|
      t.string :name, null: false
      t.string :ip_address, null: false
      t.string :path, null: false

      t.timestamps
    end
  end
end
