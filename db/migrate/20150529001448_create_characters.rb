class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
    	t.string :name
    	t.string :archetype
    	t.string :goal
    	t.string :motive
    	t.integer :brave
    	t.integer :fierce
    	t.integer :wary
    	t.integer :clever
    	t.integer :strange
    	t.integer :experience
    	t.text :posessions
    	t.text :losses
    	t.boolean :pride
    	t.boolean :health
    	t.boolean :strength
    	t.boolean :hope
    	t.boolean :life
    	t.boolean :return_brave
    	t.boolean :return_strange
    	t.boolean :return_different
    	t.boolean :dead
    	t.boolean :unprepared
    	t.text :notes
    	t.text :look

    	t.boolean :virtue_noble
    	t.boolean :virtue_strong
        t.text :virtue_strong_description
    	t.boolean :virtue_unassuming
    	t.boolean :virtue_practical
    	t.boolean :virtue_weird
        t.text :virtue_weird_description

    	t.string :artifact_name
    	t.integer :artifact_type
    	t.integer :artifact_look
    	t.text :artifact_power
    	t.text :artifact_worthy
    	t.integer :artifact_risk
    	t.string :artifact_risk_soughtby

    	t.integer :path

      t.timestamps null: false
    end
  end
end
