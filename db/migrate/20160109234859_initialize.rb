class Initialize < ActiveRecord::Migration
  def change
    create_table :trust_questions do |t|
      t.string :question
      t.integer :trust
      t.belongs_to :archetype
      t.timestamps null: false
    end

    create_table :relationships do |t|
      t.string :name
      t.integer :trust
      t.belongs_to :trust_question
      t.belongs_to :character
      t.timestamps null: false
    end

    create_table :sample_names do |t|
      t.string :name
      t.belongs_to :archetype
      t.timestamps null: false
    end

    create_table :name_categories do |t|
      t.string :name
      t.belongs_to :archetype
      t.timestamps null: false
    end

    create_table :archetypes do |t|
      t.string :name
      t.string :setting_symbol
      t.string :setting_symbol_example1
      t.string :setting_symbol_example2
      t.string :setting_symbol_example3
      t.string :setting_other
      t.string :setting_other_example1
      t.string :setting_other_example2
      t.string :setting_other_example3
      t.timestamps null: false
    end

    create_table :characters do |t|
      t.string :name
      t.belongs_to :archetype

      t.timestamps null: false
    end
  end
end
