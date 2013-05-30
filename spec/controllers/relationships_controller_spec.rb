require 'spec_helper'

describe RelationshipsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  before { cookies[:remember_token] = user.remember_token }

  context 'creating a relationship with Ajax' do
    it 'increment the Relationships count' do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it 'respond with success' do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end
  end

  context 'destroying a relationship with Ajax' do
    before { user.follow!(other_user) }
    let(:relationship) do
      user.relationships.find_by_followed_id(other_user.id)
    end
    it 'decrement the Relationship count' do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it 'respond with success' do
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end
