FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyemail#{n}@gmail.com"
    end
    name 'Ima User'
  end
end
