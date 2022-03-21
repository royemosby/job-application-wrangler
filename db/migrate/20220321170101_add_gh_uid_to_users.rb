class AddGhUidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gh_uid, :string
  end
end
