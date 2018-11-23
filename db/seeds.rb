# frozen_string_literal: true

require 'faker'

User.create!(name: 'Admin',
             email: 'admin@demo.org',
             password: 'super_admin',
             password_confirmation: 'super_admin',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@demo.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
