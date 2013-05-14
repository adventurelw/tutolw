require 'spec_helper'

feature "User Pages" do
  context "Sign up" do
    background { visit signup_path }
    context "page" do
      scenario "have the h1 'Sign up'" do
        expect(page).to have_selector('h1', text: "Sign up")
      end

      scenario "have the title 'Sign up'" do
        expect(page).to have_title(full_title("Sign up"))
      end
    end

    context "action" do
      given(:submit) { "注册账户" }
      scenario "cann't create a user with invalid information" do
        #也可以使用change(User, :count)， 块的话必须使用{}
        expect { click_button submit }.to_not change { User.count }
      end

      context "with valid information" do
        given(:user) { User.find_by_email("lavin@gmail.com") }
        before { fill_in_valid_information_for_sign_up }
        scenario "create a user sccessfully" do
          expect { click_button submit }.to change { User.count }.by(1)
        end

        scenario "after saving the user" do
          click_button submit
          expect(page).to have_title(user.name)
          expect(page).to have_success_message("Great!!!!!")
          expect(page).to have_link("退出")
        end
      end
    end
  end

  context "profile page" do
    given(:user) { FactoryGirl.create(:user) }
    background { visit user_path(user) }
    scenario "have the h1 user.name" do
      expect(page).to have_selector('h1', text: user.name)
    end

    scenario "have the title user.name" do
      expect(page).to have_title(user.name)
    end
  end

  context "edit user" do
    given(:user) { FactoryGirl.create(:user) }
    background do
      valid_sign_in user
      visit edit_user_path(user)
    end
    context "page" do
      scenario "have title" do
        expect(page).to have_title("Edit user")
      end

      scenario "have content h1" do
        expect(page).to have_selector("h1", text: "Update your profile")
      end

      scenario "have gravatar change link" do
        expect(page).to have_link("Change", href: "http://gravatar.com/emails")
      end
    end

    context "with invalid information" do
      background { click_button "Save changes" }
      scenario "have error messages" do
        expect(page).to have_content("error")
      end
    end

    context "with valid information" do
      given(:new_name) { "New Name" }
      given(:new_email) { "newname@gmail.com" }
      background do
        fill_in "用户名", with: new_name
        fill_in "邮箱", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password_confirmation
        click_button "Save changes"
      end

      scenario "have new_name title" do
        expect(page).to have_title(new_name)
      end

      scenario "have successful message" do
        expect(page).to have_success_message
      end

      scenario "have signout link" do
        expect(page).to have_link("退出")
      end

      scenario "user's name updated to new_name" do
        expect(user.reload.name).to eq(new_name)
      end

      scenario "user's email updated to new_email" do
        expect(user.reload.email).to eq(new_email)
      end
    end
  end

  context "index" do
    given(:userx) { FactoryGirl.create(:user) }
    background(:all) { 30.times { FactoryGirl.create(:user) } }
    background(:each) do
      valid_sign_in userx
      visit users_path
    end

    scenario "have All users title" do
      expect(page).to have_title('All users')
    end

    scenario "have All users h1" do
      expect(page).to have_selector('h1', text: 'All users')
    end

    context "paginate" do
      scenario "have div.paginate selector" do
        expect(page).to have_selector('div.pagination')
      end

      scenario "list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    context "delete link" do
      scenario 'have not delete link' do
        expect(page).to_not have_link('delete')
      end

      context "as an admin user" do
        given(:admin) { FactoryGirl.create(:admin) }
        background do
          sign_out
          valid_sign_in admin
          visit users_path
        end

        scenario 'have delete links' do
          expect(page).to have_link('delete', href: user_path(User.first))
        end

        scenario 'have not delete link for self' do
          expect(page).to_not have_link('delete', href: user_path(admin))
        end

        scenario 'be able to delete another user' do
          expect { click_link('delete', href: user_path(User.first)) }.to change(User, :count).by(-1)
        end
      end
    end

    after(:all) { User.delete_all }
  end
end
