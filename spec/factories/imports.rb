FactoryBot.define do
  factory :import do
    user
    contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/contacts.csv'), 'text/csv') }

    trait :with_png_contacts_file do
      contacts_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.png'), 'image/png') }
    end
  end
end
