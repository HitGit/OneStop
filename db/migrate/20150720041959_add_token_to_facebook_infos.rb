class AddTokenToFacebookInfos < ActiveRecord::Migration
  def change
    change_table :facebookinfos do |t|
      t.string :token
    end
  end
end
