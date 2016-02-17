class EditCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.rename :brave, :starting_brave
      t.rename :fierce, :starting_fierce
      t.rename :wary, :starting_wary
      t.rename :clever, :starting_clever
      t.rename :strange, :starting_strange
    end
  end
end
