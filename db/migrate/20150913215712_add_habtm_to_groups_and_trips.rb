class AddHabtmToGroupsAndTrips < ActiveRecord::Migration
  def change
    create_table :groups_trips, :id => false do |t|
      t.references :group, :null => false
      t.references :trip, :null => false
    end

    add_index(:groups_trips, [:group_id, :trip_id], :unique => true)
  end
end
