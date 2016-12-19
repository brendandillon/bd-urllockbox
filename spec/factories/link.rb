FactoryGirl.define do
  factory :link do
    title 'Example'
    url 'www.example.com'
    user_id user
  end
end
