class CreateBaseImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :base_imgs do |t|
      t.string :name, null: false
      t.integer :size, null: false
      t.string :path, null: false

      t.timestamps
    end
  end
end
