class AddUseragentToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :useragent, :string
  end
end
