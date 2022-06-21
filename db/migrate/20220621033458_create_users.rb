class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, default: '', unique: true, null: false, index: true
      t.string :password_digest, default: ''

      t.timestamps
    end
  end
end
