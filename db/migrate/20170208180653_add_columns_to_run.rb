class AddColumnsToRun < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :manual, :boolean
    add_column :runs, :size, :string
    add_column :runs, :device, :string
    add_column :runs, :url, :string
    add_column :runs, :requests, :integer
    add_column :runs, :postRequests, :interger
    add_column :runs, :httpsRequests, :interger
    add_column :runs, :notFound, :interger
    add_column :runs, :timeToFirstByte, :interger
    add_column :runs, :timeToLastByte, :interger
    add_column :runs, :bodySize, :interger
    add_column :runs, :contentLength, :integer
    add_column :runs, :httpTrafficCompleted, :interger

  end
end
