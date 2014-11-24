class ChangeProviderUidToString < ActiveRecord::Migration
  def change
    change_column :feeds, :provider_uid, :string
  end
end
