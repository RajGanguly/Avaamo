class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starttime
      t.datetime :endtime
      t.string :description
      t.boolean :allday
      t.boolean :completed

      t.timestamps
    end
  end
end
