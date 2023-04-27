class DropUserMovies < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_movies do |t|
      t.bigint :user_id, null: false
      t.integer :rating, null: false
      t.string :imdb_id
      t.timestamps null: false
    end
  end
end
