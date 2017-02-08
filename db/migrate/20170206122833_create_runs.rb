class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.references :page, foreign_key: true
      t.text :har
      t.timestamps
    end
  end
end
