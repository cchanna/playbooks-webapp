class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.belongs_to :character, index: true
      t.belongs_to :database_move, index: true
    	t.text :description
      t.integer :options, default: 0

    	t.timestamps null: false
    end
  end
end
