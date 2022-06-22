FactoryBot.define do
  factory :import do
    user
    contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/contacts.csv'), 'text/csv') }
    headers { Import::HEADERS.join(',') }

    trait :with_png_contacts_file do
      contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.png'), 'image/png') }
    end

    trait :with_invalid_contact do
      contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/invalid-contacts.csv'), 'text/csv') }
    end

    trait :with_empty_contact do
      contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/empty-contacts.csv'), 'text/csv') }
    end
  end
end
