class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
    	t.integer :sender_id
    	t.integer :recipient_id
    	t.string :status

      t.timestamps
    end
  end
end
