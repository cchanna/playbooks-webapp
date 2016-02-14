class CreateSpellbooks < ActiveRecord::Migration
  def change
    create_table :spellbooks do |t|
      t.belongs_to :character
      t.timestamps null: false
    end
  end
end
