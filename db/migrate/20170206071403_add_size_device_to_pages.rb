class AddSizeDeviceToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :size, :string
    add_column :pages, :device, :string
  end
end
