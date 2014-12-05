class CreateRouteUsers < ActiveRecord::Migration
  def change
    create_table :route_users do |t|
      t.references :user, index: true
      t.references :route, index: true

      t.timestamps
    end
  end
end
