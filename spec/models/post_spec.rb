require 'rails_helper'

RSpec.describe Post, type: :model do
  # associations
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
end
