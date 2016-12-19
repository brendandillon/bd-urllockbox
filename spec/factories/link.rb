FactoryGirl.define do
  factory :link do
    title 'Example'
    url 'http://www.example.com'
    user_id user
  end
end
