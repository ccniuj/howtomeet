class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.integer :category_id
      t.string :title
      t.string :title_en
      t.string :subtitle
      t.text :description
      t.integer :day
      t.string :location
      t.string :called
      t.string :cover
      
      t.timestamps
    end
  end
end
