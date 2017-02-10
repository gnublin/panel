class AddColumnsToRun < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :size, :string
    add_column :runs, :device, :string
  end
end
