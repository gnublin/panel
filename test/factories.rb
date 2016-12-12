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

  factory :page do
    site
    title 'My page'
    url '/toto42'
    active true
    email 'ga@doctolib.fr'
    basic_auth 'none'
    basic_password 'none'
  end

end