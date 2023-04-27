class DropReviews < ActiveRecord::Migration[5.2]
  def change
    drop_table :reviews do |t|
      t.bigint :user_id, null: false
      t.string :title, null: false
      t.text :blog, null: false
      t.string :imdb_id, null: false
      t.timestamps null: false
    end
  end
end
