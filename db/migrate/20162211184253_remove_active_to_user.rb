class RemoveActiveToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :active, :boolean
  end
end
