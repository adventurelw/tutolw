require 'spec_helper'

feature "Authentication" do
  context "Sign in page" do
    background { visit signin_path }
    scenario "have title" do
      expect(page).to have_title("Sign in")
    end

    scenario "have h1 content" do
      expect(page).to have_selector("h1", text: "Sign in")
    end
  end

  context "Sign in action" do
    context "with invalid information" do
      background { invalid_sign_in }
      scenario "have title" do
        expect(page).to have_title("Sign in")
      end

      scenario "have errors flash content" do
        expect(page).to have_error_message("Invalid")
      end

      context "after visiting another page" do
        scenario "flash will invisible" do
          click_link "Home"
          expect(page).to_not have_selector("div.alert.alert-error")
        end
      end
    end

    context "with valid information" do
      given(:user) { FactoryGirl.create(:user) }
      background { valid_sign_in user }

      scenario "have title" do
        expect(page).to have_title(user.name)
      end

      scenario "have users link" do
        expect(page).to have_link("Users", href: users_path)
      end

      scenario "have profile link" do
        expect(page).to have_link("主页", href: user_path(user))
      end

      scenario "have Signout link" do
        expect(page).to have_link("退出", href: signout_path)
      end

      scenario "have not Signin link" do
        expect(page).to_not have_link("Sign in", href: signin_path)
      end

      context "followed by signout" do
        scenario "have sign in link after singnout" do
          sign_out
          expect(page).to have_link("Sign in")
        end
      end
    end
  end

  context "authorization" do
    given(:user) { FactoryGirl.create(:user) }
    context "for non-signed-in users" do
      context 'visiting home page' do
        background { visit root_path }
        scenario 'have not profile link' do
          expect(page).to_not have_link('主页')
        end

        scenario 'have not settings link' do
          expect(page).to_not have_link('设置')
        end
      end

      context "visiting edit user page" do
        background { visit edit_user_path(user) }
        scenario "have Sign in title" do
          expect(page).to have_title("Sign in")
        end

        scenario "redirect to edit page after sign in" do
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "登录"
          expect(page).to have_title("Edit user")
        end
      end

      context "visiting index page" do
        scenario "have Sign in title" do
          visit users_path
          expect(page).to have_title("Sign in")
        end
      end
    end

    context "as wrong user" do
      given(:wrong_user) { FactoryGirl.create(:user, email: "wrong@gmail.com") }
      scenario "have no Edit user title" do
        valid_sign_in user
        visit edit_user_path(wrong_user)
        expect(page).to_not have_title("Edit user")
      end
    end
  end
end
