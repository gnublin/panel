class AddSiteIdToPagesBelongsToSite < ActiveRecord::Migration[5.0]
  def change
    add_reference(:pages, :site)
  end
end
