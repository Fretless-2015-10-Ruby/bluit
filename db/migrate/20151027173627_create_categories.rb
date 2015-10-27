class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, length: 20
      t.text :description
      t.timestamps
    end
  end
end
