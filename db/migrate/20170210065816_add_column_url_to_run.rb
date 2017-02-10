class AddColumnUrlToRun < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :url, :string
  end
end
