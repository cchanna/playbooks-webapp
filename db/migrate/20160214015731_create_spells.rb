class CreateSpells < ActiveRecord::Migration
  def change
    create_table :spells do |t|
      t.belongs_to :spellbook
      t.string :name
      t.boolean :dangerous
      t.boolean :dark
      t.boolean :time
      t.boolean :attention
      t.boolean :spirit
      t.string :cost
      t.text :effects
      t.timestamps null: false
    end
  end
end
