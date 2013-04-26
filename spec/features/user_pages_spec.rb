require 'spec_helper'

feature "User Pages" do
  background { visit signup_path }
  scenario "have the h1 'Sign up'" do
    expect(page).to have_selector('h1', "Sign up")
  end

  scenario "have the title 'Sign up'" do
    expect(page).to have_title(full_title("Sign up"))
  end
end
