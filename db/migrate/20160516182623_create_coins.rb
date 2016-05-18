class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.integer :value
      t.integer :count
      t.references :exchange
    end
  end
end
