class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.string :name
      t.string :twitter_id
    end
  end
end
