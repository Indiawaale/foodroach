class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.time :start_time
      t.time :end_time
      t.date :date
      t.boolean :alcohol
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
