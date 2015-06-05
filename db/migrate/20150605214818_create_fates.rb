class CreateFates < ActiveRecord::Migration
  def change
    create_table :fates do |t|
    	t.belongs_to :character, index: true
    	t.string :name
    	t.integer :value

    	t.timestamps null: false
    end
  end
end

