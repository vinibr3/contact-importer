class AddHeadersToImports < ActiveRecord::Migration[7.0]
  def change
    add_column :imports, :headers, :text
  end
end
