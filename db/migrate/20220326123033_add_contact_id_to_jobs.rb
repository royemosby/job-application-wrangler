class AddContactIdToJobs < ActiveRecord::Migration[7.0]
  def change
    change_table :jobs do |t|
      t.references :contact, null: true, foreign_key: true
    end
  end
end