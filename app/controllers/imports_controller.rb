# frozen_string_literal: true

class ImportsController < ApplicationController
  def index
    @imports = current_user.imports
                           .with_attached_contacts_file
                           .order(created_at: :desc)
                           .page(params[:page])
  end

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(valid_params)

    if @import.save
      Imports::ProcessorJob.perform_later(@import)
      redirect_to imports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def valid_params
    params.require(:import)
          .permit(:headers, :contacts_file)
          .merge(user: current_user)
  end
end
