class AddAppliedDateToJob < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :date_applied, :date
  end
end
