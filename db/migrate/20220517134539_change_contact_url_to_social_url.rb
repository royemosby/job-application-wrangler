class ChangeContactUrlToSocialUrl < ActiveRecord::Migration[7.0]
  def change
    rename_column :contacts, :url, :social_url
  end
end
