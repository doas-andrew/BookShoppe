class CreateTradeBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_books do |t|
      t.belongs_to :trade
      t.belongs_to :user_book

      t.timestamps
    end
  end
end
