class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, default: '', null: false
      t.date :date_of_birth, null: false
      t.string :telephone, default: '', null: false
      t.text :address, default: '', null: false
      t.text :credit_card_digest, default: '', null: false
      t.string :last_credit_card_numbers, default: '', null: false
      t.string :franchise, default: '', null: false
      t.string :email, default: '', null: false, index: true
      t.references :import, null: false, foreign_key: true

      t.timestamps
    end
  end
end
