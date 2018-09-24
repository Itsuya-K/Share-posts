class AddReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :blogs, :user
  end
end
