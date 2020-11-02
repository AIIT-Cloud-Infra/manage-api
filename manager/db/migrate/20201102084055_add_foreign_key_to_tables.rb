class AddForeignKeyToTables < ActiveRecord::Migration[6.0]
  def up
    add_foreign_key :instances, :base_imgs
    add_foreign_key :instances, :servers
    add_foreign_key :instances, :users
    add_foreign_key :ssh_keys, :instances
  end

  def down
    remove_foreign_key :instances, :base_imgs
    remove_foreign_key :instances, :servers
    remove_foreign_key :instances, :users
    remove_foreign_key :ssh_keys, :instances
  end
end
