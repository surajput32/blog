FactoryBot.define do
  factory :post do
    name { 'Test name' }
    title { 'Test title' }
    content { 'Test content' }
    user
  end
end
