class CreateSshKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :ssh_keys do |t|
      t.text :value, nulll: false, limit: 16777215
      t.references :instance

      t.timestamps
    end
  end
end
