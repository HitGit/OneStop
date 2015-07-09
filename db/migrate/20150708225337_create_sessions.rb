class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :account_id
    end
  end
end
