class AddCounterCacheComments < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :comments_count, :integer, default: 0
    add_column :lessons, :comments_count, :integer, default: 0
  end
end
