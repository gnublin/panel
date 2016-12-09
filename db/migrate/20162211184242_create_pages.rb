class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :url
      t.boolean :active
      t.string :email
      t.string :basic_auth
      t.string :basic_password
      t.timestamps
    end
  end
end
