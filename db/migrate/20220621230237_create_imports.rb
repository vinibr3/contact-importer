class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |t|
      t.references :user
      t.integer :status, size: 2, index: true, default: 0
      t.timestamps
    end
  end
end
