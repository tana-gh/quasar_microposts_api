class AddIndexToUserSession < ActiveRecord::Migration[5.1]
  def change
    add_index :user_sessions, :token, unique: true
  end
end
