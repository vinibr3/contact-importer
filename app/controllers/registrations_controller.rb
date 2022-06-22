# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(valid_params)

    if @user.save
      sign_in(@user)
      redirect_to imports_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def valid_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end
end
