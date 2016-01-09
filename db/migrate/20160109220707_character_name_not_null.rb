class CharacterNameNotNull < ActiveRecord::Migration
  def change
    change_column_null :characters, :name, false
    reversible do |dir|
      dir.up do
        change_column_default :characters, :name, "<name>"
      end
      dir.down do
        change_column_default :characters, :name, nil
      end
    end
  end
end
