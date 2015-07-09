class AddUsersFkeyToFbinfo < ActiveRecord::Migration
  def change
    change_table :facebookinfos do |t|
      t.references :user
    end
  end
end
