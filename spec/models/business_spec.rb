require 'spec_helper'

describe Business do
  it { should have_many(:reviews) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:picture_url) }
  it { should validate_uniqueness_of(:name) }
end
