class AddKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :gcm, :text
  end
end
