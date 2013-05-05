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

      scenario "create a user with valid information" do
        #都是form表单的文本标签，首字母大写
        fill_in "Name", with: "Lavin"
        fill_in "Email", with: "lavin@gmail.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"

        expect { click_button submit }.to change { User.count }.by(1)
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
end
