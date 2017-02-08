class AddColumnToRun < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :manual, :boolean
  end
end
