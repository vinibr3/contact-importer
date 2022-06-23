# frozen_string_literal: true

class ErrorLogsController < ApplicationController
  def index
    @import = current_user.imports.find(params[:import_id])
    @error_logs = current_user.error_logs
                              .where(import: @import)
                              .order(created_at: :desc)
                              .page(params[:page])
  end
end
