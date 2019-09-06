FactoryBot.define do
  factory :task do
    name { 'Rspecだぞお'}
    description { 'Rspecを書くぞお'}
    user
  end
end