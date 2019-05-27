class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, unique: true
      t.string :password_digest
      t.string :phone_number
      t.string :address
      t.string :image_url
      
    	t.timestamps
    end
  end
end