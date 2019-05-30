class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :sender
      t.belongs_to :recipient
      t.belongs_to :trade
      t.text :content

      t.timestamps
    end
  end
end
