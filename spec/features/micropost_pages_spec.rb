require 'spec_helper'

feature 'Micropost pages' do
  given(:user) { FactoryGirl.create(:user) }
  background { valid_sign_in user }

  context 'micropost creation' do
    background { visit root_path }

    context 'with invalid information' do
      scenario 'cannot create a micropost' do
        expect { click_button 'Post' }.to_not change(Micropost, :count)
      end

      scenario 'have error messages' do
        click_button 'Post'
        expect(page).to have_content('error')
      end
    end

    context 'with valid information' do
      background { fill_in 'micropost_content', with: 'Lareom' }
      scenario 'will create a micropost' do
        expect { click_button 'Post' }.to change { Micropost.count }.by(1)
      end
    end
  end

  context 'micropost destruction' do
    background { FactoryGirl.create(:micropost, user: user) }
    context 'as correct user' do
      background { visit root_path }
      scenario 'can delete a micropost' do
        expect { click_link 'delete' }.to change { Micropost.count }.by(-1)
      end
    end

    context 'as incorrect user' do
      background do
        sign_out
        valid_sign_in FactoryGirl.create(:user)
        visit user_path(user)
      end

      scenario 'have not delete link' do
        expect(page).to_not have_link('delete')
      end
    end
  end
end
