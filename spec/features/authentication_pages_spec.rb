require 'spec_helper'

feature "Authentication" do
  background { visit signin_path }
  context "Sign in page" do
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
end
