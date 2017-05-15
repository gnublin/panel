FactoryGirl.define do
  factory :user do
    email 'alice@cooper.com'
    password 'toto42'
  end

  factory :user_admin, class: User do
    email 'alice_admin@cooper.com'
    password 'toto42'
    admin true
  end

  factory :site do
    name 'My super site'
    url 'http://example.org'
    user
  end

  factory :page do
    site
    title 'My page1'
    url 'toto41'
    active true
    email 'ga@doctolib.fr'
    basic_auth 'none'
    basic_password 'none'
  end

  sequence :requests do
    rand(1..10)
  end

  sequence :postRequests do
    rand(5)
  end

  sequence :notFound do
    rand(5)
  end

  sequence :httpsRequests do
    rand(5)
  end

  sequence :timeToLastByte do
    rand(30..100)
  end

  sequence :timeToFirstByte do
    rand(30..50)
  end

  sequence :bodySize do
    rand(1_300_000..3_000_000)
  end

  sequence :contentLength do
    rand(1_300_000..3_000_000)
  end

  sequence :httpTrafficCompleted do |_htc|
    rand(200..5_000)
  end

  factory :run do
    page
    har 'null'
    requests
    postRequests
    httpsRequests
    notFound
    timeToFirstByte
    timeToLastByte
    bodySize
    contentLength
    httpTrafficCompleted
    manual true
    device 'Computer'
    size '1980x1024'
    url 'http://example.org/toto41'
  end
end
