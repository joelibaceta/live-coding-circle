class AddUserIdToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :message, :user_id, :string
  end
end
