require 'machinist'
require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  login                 { Faker::Internet.user_name }
  body                  { Faker::Lorem.sentences(5) }
  password              { "password" }
  password_confirmation { "password" }
end

Message.blueprint do
  body
  user
end

Message.blueprint(:private) do
  private(true)
end

User.blueprint do
  login
  twitter_id { rand(99999) }
  password
  password_confirmation
end

User.blueprint(:protected) do
  protected(true)
end