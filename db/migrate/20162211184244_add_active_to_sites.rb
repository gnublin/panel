class AddActiveToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :active, :boolean
  end
end
