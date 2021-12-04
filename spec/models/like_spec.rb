require 'rails_helper'

RSpec.describe Like, type: :model do
  # associations
  it { should belong_to(:user) }
  it { should belong_to(:likeable) }
end
