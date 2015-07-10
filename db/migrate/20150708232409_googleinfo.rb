class Googleinfo < ActiveRecord::Migration
  def change
    create_table :googleinfos do |t|
      t.column :email, :string
      t.column :user, :string
      t.column :email, :string
      t.column :first_name, :string
      t.column :last_name, :string

      t.references :user
    end
  end
end
