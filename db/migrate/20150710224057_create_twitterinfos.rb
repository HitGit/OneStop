class CreateTwitterinfos < ActiveRecord::Migration
  def change
    create_table :twitterinfos do |t|
      t.integer :uid
      t.string :name
      t.string :nickname
      t.string :location
      t.string :description
      t.string :token
      t.string :secret
      t.integer :followers_count
      t.integer :friends_count
      t.integer :user_id
    end
  end
end
