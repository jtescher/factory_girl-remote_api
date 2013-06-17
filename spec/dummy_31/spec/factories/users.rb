# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
  end

  factory :authenticated_user, parent: :user do
    first_name 'Jane'
    last_name  'Doe'
  end
end
