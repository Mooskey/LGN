class CreateEventsUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :events_users, id: false do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :is_host
    end

    #add_index :events_users, event_id
    #add_index :events_users, user_id
  end
end
