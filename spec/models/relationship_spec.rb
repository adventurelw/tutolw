require 'spec_helper'

describe Relationship do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) do
    follower.relationships.build(followed_id: followed.id)
  end
  subject { relationship }
  it 'relationship is valid' do
    expect(subject).to be_valid
  end

  context 'follower method' do
    it 'respond_to follower' do
      expect(subject).to respond_to(:follower)
      expect(subject.follower).to eq(follower)
    end

    it 'respond_to followed' do
      expect(subject).to respond_to(:followed)
      expect(subject.followed).to eq(followed)
    end
  end

  context 'is invalid' do
    it 'followed_id is not present' do
      subject.followed_id = nil
      expect(subject).to_not be_valid
    end

    it 'follower_id is not present' do
      subject.follower_id = nil
      expect(subject).to_not be_valid
    end
  end
end
