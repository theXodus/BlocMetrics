require 'faker'

user = User.create!(
  email: 'test@example.com',
  password: 'foobar'
)

5.times do
  RegisteredApplication.create!(
    name: Faker::Internet.domain_word,
    url:  Faker::Internet.domain_name,
    user: user
  )
end

apps = RegisteredApplication.all

100.times do
  name = ["visit", "click", "subscription", "bounce", "submit"]
  Event.create!(
    name: name.sample,
    registered_application: apps.sample
    created_at: Faker::Date.between(10.days.ago, Date.today)
  )
end

puts "#{User.count} user created"
puts "#{RegisteredApplication.count} apps created"
puts "#{Event.count} events created"
