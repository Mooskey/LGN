class AddDefaultsToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:users, :username, "")
    change_column_default(:users, :first_name, "")
    change_column_default(:users, :last_name, "")
    change_column_default(:users, :address, "")
    change_column_default(:users, :city, "")
    change_column_default(:users, :state, "")
    change_column_default(:users, :zip, "")
    change_column_default(:users, :country, "")
    change_column_default(:users, :bio, "")
    change_column_default(:users, :fb, "")
    change_column_default(:users, :steam, "")
    change_column_default(:users, :psn, "")
    change_column_default(:users, :xbox, "")
    change_column_default(:users, :twitch, "")
  end
end
