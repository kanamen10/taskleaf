FactoryBot.define do
  # factory :admin_user, class: User do
  factory :user do
    name { 'テストユーザ' }
    email { 'test@test.com' }
    password { 'password' }
  end
end