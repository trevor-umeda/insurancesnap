

#Factory.sequence :email do |n|
#  "person#{n}@example.com"
#end

Factory.define :user do |u|
  u.name 'Test User'
  #u.email " Factory.next(:email) "
  u.email "test@email.com"
  u.password 'password'
  u.password_confirmation 'password'
end

Factory.define :item do |f|
  f.name  "chair"
  f.description "it's a chair"
  f.price  33.00
  f.snapshot_id  1
  f.user_id 1
end

Factory.define :snapshot do |s|
  s.title "Living Room"
  s.photo File.new(Rails.root + 'spec/images/rails.png')
end