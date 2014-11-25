class AddingProviderId < ActiveRecord::Migration
  def change
    add_column :posts, :provider_id, :string
  end
end
