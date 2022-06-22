class AddContactsFileHasHeaderToImports < ActiveRecord::Migration[7.0]
  def change
    add_column :imports, :contacts_file_has_header, :boolean, default: false
  end
end
