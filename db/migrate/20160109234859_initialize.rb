class Initialize < ActiveRecord::Migration
  def change
    create_table :gift_types do |t|
      t.string :name
    end

    create_table :gift_curses do |t|
      t.string :name
    end

    create_table :def_tools do |t|
      t.string :name
    end

    create_table :example_tools do |t|
      t.string :example
      t.belongs_to :def_tool
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
      t.integer :starting_move_count
      t.integer :brave
      t.integer :fierce
      t.integer :wary
      t.integer :clever
      t.integer :strange
    end

    create_table :def_vows do |t|
      t.string :name
      t.string :text
    end

    create_table :def_dire_fates do |t|
      t.string :text
      t.integer :peril
      t.belongs_to :archetype
    end

    create_table :def_fates do |t|
      t.belongs_to :archetype
      t.string :name
      t.text :description
      t.string :advance
      t.string :complete
    end

    create_table :def_moves do |t|
      t.string :name
      t.belongs_to :archetype
      t.string :stat
      t.text :body
      t.boolean :has_description, default: false
      t.boolean :free, default: false
      t.integer :options_selectable
    end

    create_table :def_move_fields do |t|
      t.belongs_to :def_move
      t.string :name
      t.boolean :creatable, default: false
    end

    create_table :def_move_options do |t|
      t.belongs_to :def_move
      t.string :option
    end

    create_table :def_looks do |t|
      t.string :look
      t.belongs_to :archetype
    end

    create_table :sample_names do |t|
      t.string :name
      t.belongs_to :archetype
    end

    create_table :name_categories do |t|
      t.string :name
      t.belongs_to :archetype
    end

    create_table :trust_questions do |t|
      t.string :question
      t.integer :trust
      t.belongs_to :archetype
    end

    create_table :characters do |t|
      t.string :name
      t.belongs_to :archetype
      t.boolean :setting, default: false
      t.integer :brave
      t.integer :fierce
      t.integer :wary
      t.integer :clever
      t.integer :strange
      t.integer :spirit
      t.timestamps null: false
    end

    create_table :vows do |t|
      t.belongs_to :character
      t.belongs_to :def_vow
      t.string :detail
      t.timestamps null: false
    end

    create_table :gifts do |t|
      t.belongs_to :character
      t.belongs_to :gift_type
      t.belongs_to :gift_curse
      t.string :name
      t.text :description
      t.string :detail
      t.timestamps null: false
    end

    create_table :dire_fates do |t|
      t.belongs_to :character
      t.belongs_to :def_dire_fate
      t.boolean :checked, default: false
      t.timestamps null: false
    end

    create_table :looks do |t|
      t.belongs_to :character
      t.belongs_to :def_look
      t.timestamps null: false
    end

    create_table :fates do |t|
      t.belongs_to :character
      t.belongs_to :def_fate
      t.integer :advancement
      t.boolean :completed, default: false
      t.timestamps null: false
    end

    create_table :moves do |t|
      t.belongs_to :character
      t.belongs_to :def_move
      t.text :description
      t.timestamps null: false
    end

    create_table :move_fields do |t|
      t.belongs_to :move
      t.belongs_to :def_move_field
      t.string :text
      t.timestamps null: false
    end

    create_table :move_options do |t|
      t.belongs_to :move
      t.belongs_to :def_move_option
      t.timestamps null: false
    end

    create_table :relationships do |t|
      t.string :name
      t.integer :trust
      t.belongs_to :trust_question
      t.belongs_to :character
      t.timestamps null: false
    end

    create_table :tools do |t|
      t.belongs_to :character
      t.belongs_to :def_tool
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end
