class CreateAdminCategories < ActiveRecord::Migration
  def change
    create_table :admin_categories do |t|

      t.timestamps
    end
  end
end
