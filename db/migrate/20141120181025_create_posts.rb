class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :date
      t.text :text_content
      t.string :media_url
      t.integer :feed_id

      t.timestamps
    end
  end
end
