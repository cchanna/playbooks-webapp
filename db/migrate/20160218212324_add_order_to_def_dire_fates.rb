class AddOrderToDefDireFates < ActiveRecord::Migration
  def change
    add_column :def_dire_fates, :order, :integer
  end
end
