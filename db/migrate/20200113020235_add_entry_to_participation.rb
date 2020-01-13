class AddEntryToParticipation < ActiveRecord::Migration[5.1]
  def change
  	add_column :participations, :entry, :string
  end
end
