class AddErrorLogsCountToImports < ActiveRecord::Migration[7.0]
  def change
    add_column :imports, :error_logs_count, :integer, default: 0
  end
end
