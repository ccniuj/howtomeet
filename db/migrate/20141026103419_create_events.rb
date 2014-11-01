class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :meetup_id
      t.string :subject
      t.string :subject_en
      t.text :content
      t.datetime :date
      t.string :place
      t.string :price
      t.integer :score
      t.timestamps
    end
  end
end
