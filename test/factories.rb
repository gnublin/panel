FactoryGirl.define do
  factory :user do
    email "alice@cooper.com"
    password "toto42"
  end

  factory :site do
    name "My super site"
    url "http://example.org"
    user
  end
end
