class RemoveTest1FromFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorites, :test1, :string
  end
end
