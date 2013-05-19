require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before { @mpost = user.microposts.build(content: 'Lalallala') }
  subject { @mpost }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'respond user' do
    expect(subject).to respond_to(:user)
    expect(subject.user).to eq(user)
  end

  context 'is invalid' do
    it 'user_id is not present' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'content is blank' do
      subject.content = ''
      expect(subject).to_not be_valid
    end

    it 'content is too long' do
      subject.content = 'La' * 120
      expect(subject).to_not be_valid
    end
  end
end
