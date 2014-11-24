class AddDisplayNameToFeedTable < ActiveRecord::Migration
  def change
    add_column :feeds, :display_name, :string
  end
end
