class CreateDatabaseMoves < ActiveRecord::Migration
  def change
    create_table :database_moves do |t|
    	t.string :name
    	t.string :stat
    	t.string :archetype
    	t.text :text
    	t.text :options
    	t.boolean :has_description?

      t.timestamps null: false
    end
  end
end
