class CreateTradeBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_books do |t|
    	t.integer :trade_id
    	t.integer :user_book_id

      t.timestamps
    end
  end
end
