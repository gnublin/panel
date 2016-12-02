class RemoveSiteIdToPages < ActiveRecord::Migration[5.0]
  def change
    remove_column :pages, :site_id, :integer
  end
end
