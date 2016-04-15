class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :story_id
      t.integer :location_id
      t.integer :elevation
      t.integer :under
      t.string :latitude
      t.string :longitude
      t.string :photo_original
      t.string :photo_story

      t.timestamps
    end
  end
end
