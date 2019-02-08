class AddUserIdToSecrets < ActiveRecord::Migration[5.2]
  def change
    add_column :secrets, :user_id, :integer
  end
end
