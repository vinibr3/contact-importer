class CreateErrorLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :error_logs do |t|
      t.integer :row, null: false
      t.text :message, default: '', null: false
      t.references :import

      t.timestamps
    end
  end
end
