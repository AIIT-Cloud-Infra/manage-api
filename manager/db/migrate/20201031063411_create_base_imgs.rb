class CreateBaseImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :base_imgs do |t|
      t.string :name
      t.string :ip_address
      t.string :path

      t.timestamps
    end
  end
end
