class AddNotesToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :notes, :text
  end
end
