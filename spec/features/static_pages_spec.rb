require 'spec_helper'

feature "StaticPages" do
  let(:base_title) { "Ruby on Rails Tutorial App" }
  context "Home page" do
    background { visit "/static_pages/home" }
    scenario "have content 'Tutorial App'" do
      #page.should have_selector('h1', 'Tutorial App')
      expect(page).to have_selector('h1', 'Tutorial App')
    end

    scenario "have the base title" do
      expect(page).to have_title(base_title)
    end

    scenario "have not a custom title" do
      expect(page).to_not have_title("| Home")
    end
  end

  context "Help Page" do
    background { visit "/static_pages/help"}
    scenario "have content 'Help'" do
      expect(page).to have_selector('h1', 'Help')
    end

    scenario "have the right title" do
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  context "About Page" do
    background { visit "/static_pages/about" }
    scenario "have content 'About Us'" do
      expect(page).to have_selector('h1', 'About Us')
    end

    scenario "have the right title" do
      expect(page).to have_title("#{base_title} | About")
    end
  end
end
