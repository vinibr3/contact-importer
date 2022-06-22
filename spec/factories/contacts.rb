FactoryBot.define do
  factory :contact do
    name { Faker::Name.first_name }
    date_of_birth_iso8601 { [Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y%m%d'),
                             Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%F')].sample }
    telephone { ['(+57) 320 432 05 09', '(+57) 320-432-05-09'].sample }
    address { Faker::Address.street_address }
    credit_card { ['371449635398431', '30569309025904', '6011111111111117', '5555555555554444', '4012888888881881'].sample }
    email { Faker::Internet.email }
    import

    trait :with_credit_card_american_express do
      credit_card { Faker::Finance.credit_card(:american_express).gsub(/\D/, '') }
    end

    trait :with_credit_card_visa do
      credit_card { Faker::Finance.credit_card(:visa).gsub(/\D/, '') }
    end

    trait :with_credit_card_master_card do
      credit_card { Faker::Finance.credit_card(:mastercard).gsub(/\D/, '') }
    end

    trait :with_credit_card_diners do
      credit_card { '30036592321275' }
    end

    trait :with_credit_card_jcb do
      credit_card { Faker::Finance.credit_card(:jcb).gsub(/\D/, '') }
    end

    trait :with_credit_card_discover do
      credit_card { Faker::Finance.credit_card(:discover).gsub(/\D/, '') }
    end

    trait :with_valid_number_white_spaced do
      telephone { '(+57) 320 432 05 09' }
    end

    trait :with_valid_number_minus_spaced do
      telephone { '(+57) 320-432-05-09' }
    end

    trait :with_valid_date_of_birth_iso8601 do
      birthday = Faker::Date.birthday(min_age: 18, max_age: 65)

      date_of_birth_iso8601 { [birthday.strftime('%Y%m%d'), birthday.strftime('%F')].sample }
    end

    trait :with_nonexistent_birth_of_date do
      date_of_birth_iso8601 { ['20220631', '2022-06-31'].sample }
    end
  end
end
