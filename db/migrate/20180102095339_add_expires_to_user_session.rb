class AddExpiresToUserSession < ActiveRecord::Migration[5.1]
  def change
    add_column :user_sessions, :expires, :datetime
  end
end
