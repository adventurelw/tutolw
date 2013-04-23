require 'spec_helper'

feature "StaticPages" do
  let(:same_title) { "Ruby on Rails Tutorial App | " }
  context "Home page" do
    scenario "have content 'Tutorial App'" do
      visit '/static_pages/home'
      #page.should have_selector('h1', 'Tutorial App')
      expect(page).to have_selector('h1', 'Tutorial App')
    end

    scenario "have the right tscenariole" do
      visit "/static_pages/home"
      expect(page).to have_title("#{same_title}Home")
    end
  end

  context "Help Page" do
    scenario "have content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', 'Help')
    end

    scenario "have the right title" do
      visit "/static_pages/help"
      expect(page).to have_title("#{same_title}Help")
    end
  end

  context "About Page" do
    scenario "have content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', 'About Us')
    end

    scenario "have the right title" do
      visit "/static_pages/about"
      expect(page).to have_title("#{same_title}About")
    end
  end
end
