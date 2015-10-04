class AddDartmouthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dartmouth, :boolean
  end
end
