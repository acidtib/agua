class AddShareToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :share, :boolean
  end
end
