require 'spec_helper'

describe "User authorize" do
  let(:user) { FactoryGirl.create(:user) }
  context "for non-signed-in users" do
    it "submitting to the update action" do
      patch user_path(user)
      expect(response).to redirect_to(signin_path)
    end

    context 'in the Microposts controller' do
      it 'submitting to the create action' do
        post microposts_path
        expect(response).to redirect_to(signin_path)
      end

      it 'submitting to the destroy action' do
        delete micropost_path(FactoryGirl.create(:micropost))
        expect(response).to redirect_to(signin_path)
      end
    end

    context 'in the Relationships controller' do
      it 'submitting to the create action' do
        post relationships_path
        expect(response).to redirect_to(signin_path)
      end

      it 'submitting to the destroy action' do
        delete relationship_path(1)
        expect(response).to redirect_to(signin_path)
      end
    end
  end

  context 'as signed-in user' do
    before { set_user_cookies(user) }
    it 'submitting a GET request to the User#new action' do
      get new_user_path
      expect(response).to redirect_to(root_path)
    end

    it 'submitting a POST request to the User#create action' do
      post users_path
      expect(response).to redirect_to(root_path)
    end
  end

  context "as wrong user" do
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@gmail.com") }
    it "submitting a PATCH request to the Users#update action" do
      set_user_cookies(user)
      patch user_path(wrong_user)
      expect(response).to redirect_to(root_path)
    end
  end

  context 'as non-admin user' do
    let(:non_admin) { FactoryGirl.create(:user) }
    it 'submitting a DELETE request to the User#destroy action' do
      set_user_cookies(non_admin)
      delete user_path(user)
      expect(response).to redirect_to(root_path)
    end
  end

  context 'as admin user' do
    it 'submitting a DELETE request to the User#destroy action for self' do
      user.toggle!(:admin)
      set_user_cookies(user)
      delete user_path(user)
      expect(response).to redirect_to(root_path)
    end
  end
end
