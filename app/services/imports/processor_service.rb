# frozen_string_literal: true

require 'csv'

class Imports::ProcessorService < ApplicationService
  def call
    ActiveRecord::Base.transaction do
      @import.processing!
      read_contacts_file_and_create_contacts
      update_after_processing_status
      @import
    end
  end

  private

  def initialize(args)
    @import = args[:import]
    @rows_count = 0
    @errors_count = 0
  end

  def read_contacts_file_and_create_contacts
    CSV.parse(@import.contacts_file.download, headers: @import.headers) do |row|
      @rows_count = @rows_count + 1
      contact = Contact.new(row.to_hash.merge(import: @import))

      create_error_log(contact, @rows_count) unless contact.save
    end
  end

  def create_error_log(contact, rows_count)
    @errors_count = @errors_count + 1

    message = contact.errors.full_messages.join(', ')
    @import.error_logs.create!(row: rows_count, message: message)
  end

  def update_after_processing_status
    none_contact_created = @rows_count > 0 && @errors_count == @rows_count

    none_contact_created ? @import.failed! : @import.terminated!
  end
end
