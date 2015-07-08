class CreateFacebookinfos < ActiveRecord::Migration
  def change
    create_table :facebookinfos do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email,              null: false, default: ""
      t.string :gender
      t.string :image
      t.string :uid
      t.string :locale

      t.string :encrypted_password, null: false, default: ""

      t.timestamps null: false

    end
  end
end
