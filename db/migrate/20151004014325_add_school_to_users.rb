class AddSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school, :integer
  end
end
