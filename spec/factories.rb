FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Lavin_#{ n }" }
    sequence(:email) { |n| "lavin_#{ n }@gmail.com" }
    password 'foobar'
    password_confirmation 'foobar'
    factory :admin do
      admin true
    end
  end
end
