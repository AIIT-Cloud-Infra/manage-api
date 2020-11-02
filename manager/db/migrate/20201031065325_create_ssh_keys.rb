class CreateSshKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :ssh_keys do |t|
      t.string :value, nulll: false
      t.references :instance

      t.timestamps
    end
  end
end
