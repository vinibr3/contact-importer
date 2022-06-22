# frozen_string_literal: true

class ImportsController < ApplicationController
  def index
    @imports = current_user.imports.page(params[:page])
  end

  def new
    @import = Import.new
  end
end
