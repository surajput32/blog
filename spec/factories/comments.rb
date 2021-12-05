FactoryBot.define do
  factory :comment do
    body { 'Test body' }
    post
    user
  end
end
