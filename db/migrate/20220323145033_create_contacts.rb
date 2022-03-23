class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :type
      t.string :email
      t.string :url
      t.string :phone
      t.text :notes

      t.timestamps
    end
  end
end
