class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :link
      t.integer :prep_time
      t.string :cuisine
    end
  end
end
