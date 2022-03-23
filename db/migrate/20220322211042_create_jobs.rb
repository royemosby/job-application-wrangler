class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :type
      t.string :company
      t.string :location
      t.string :is_remote
      t.string :status
      t.string :posting_url
      t.string :logo_url
      t.date :date_posted
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
