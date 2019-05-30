class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.belongs_to :sender
      t.belongs_to :recipient
    	t.string :status
    	t.boolean :sender_complete, default: false
    	t.boolean :recipient_complete, default: false

      t.timestamps
    end
  end
end
