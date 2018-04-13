class RemoveLikeCountToPrototypes < ActiveRecord::Migration
  def change
    remove_column :prototypes, :like_count, :integer
  end
end
