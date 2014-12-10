class AddMilesToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :miles, :float
  end
end
