class CreateImprovements < ActiveRecord::Migration
  def change
    create_table :improvements do |t|
      t.belongs_to :character
      t.belongs_to :def_improvement

      t.timestamps null: false
    end

    create_table :stat_changes do |t|
      t.belongs_to :improvement
      t.string :stat
      t.integer :value, default: 1
    end

    change_table :moves do |t|
      t.belongs_to :improvement
    end

    change_table :tools do |t|
      t.belongs_to :improvement
      t.integer :replaces
    end

    change_table :vows do |t|
      t.belongs_to :improvement
      t.integer :replaces
    end

    change_table :gifts do |t|
      t.belongs_to :improvement
    end
  end
end
