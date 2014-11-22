class ChangeDisplayNameToProfileUrl < ActiveRecord::Migration
  def change
    rename_column :feeds, :display_name, :profile_url
  end
end
