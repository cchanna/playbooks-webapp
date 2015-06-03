class AddIndexToCharactersSlug < ActiveRecord::Migration
  def change
  	add_index :characters, :slug
  end
end
