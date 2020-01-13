class AddColumnsToParticipation < ActiveRecord::Migration[5.1]
  def change
  	add_column :participations, :event_name, :string
  	add_column :participations, :completed, :boolean
  	add_reference :participations, :user, foreign_key: true
  	add_reference :participations, :event, foreign_key: true
  end
end
