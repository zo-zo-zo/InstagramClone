class AddPictureToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :picture, :text
  end
end
