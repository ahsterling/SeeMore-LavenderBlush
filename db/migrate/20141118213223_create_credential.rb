class CreateCredential < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
