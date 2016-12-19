class ChangeLinkFromUserIdToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :links, :user_id
  end
end
