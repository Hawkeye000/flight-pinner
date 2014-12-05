class AddDateToRouteUsers < ActiveRecord::Migration
  def change
    add_column :route_users, :date, :date
  end
end
