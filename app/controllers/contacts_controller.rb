# frozen_string_literal: true

class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @contacts = current_user.contacts
                            .order(created_at: :desc)
                            .page(params[:page])
  end
end
