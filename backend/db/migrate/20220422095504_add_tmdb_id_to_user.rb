class AddTmdbIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tmdb_id, :integer
  end
end
