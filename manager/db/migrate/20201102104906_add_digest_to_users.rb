class AddDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
  end
end
