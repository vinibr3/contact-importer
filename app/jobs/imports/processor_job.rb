# frozen_string_literal: true

class Imports::ProcessorJob < ApplicationJob
  queue_as :default

  def perform(import)
    Imports::ProcessorService.call(import: import)
  end
end
