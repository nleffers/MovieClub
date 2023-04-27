class AddMovieWatchlistToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :movie_watchlist, :text, default: [].to_yaml
  end
end
