class Initialize < ActiveRecord::Migration
  def change
    create_table :archetypes do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :characters do |t|
      t.string :name
      t.belongs_to :archetype
      t.string :creation_step

      t.timestamps null: false
    end
  end
end
