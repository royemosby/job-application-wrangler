class RemoveGhEmailGhNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :gh_email
    remove_column :users, :gh_name
  end
end
