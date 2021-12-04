require 'rails_helper'

RSpec.describe Comment, type: :model do
  # associations
  it { should belong_to(:post) }
  it { should belong_to(:user) }
  it { should have_many(:likes) }
end
