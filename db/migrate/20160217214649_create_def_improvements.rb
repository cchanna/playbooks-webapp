class CreateDefImprovements < ActiveRecord::Migration
  def change
    create_table :def_improvements do |t|
      t.belongs_to :archetype
      t.string :action
      t.string :value
      t.integer :order
    end
  end
end
