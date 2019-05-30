class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.belongs_to :sender
      t.belongs_to :recipient
    	t.string :status

      t.timestamps
    end
  end
end
