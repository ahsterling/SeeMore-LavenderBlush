class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :handle
      t.string :avatar
      t.string :provider
      t.integer :provider_uid

      t.timestamps
    end
  end
end
