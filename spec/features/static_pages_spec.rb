require 'spec_helper'

feature "StaticPages" do
  let(:base_title) { "Ruby on Rails Tutorial App" }
  context "Home page" do
    background { visit root_path }
    scenario "have the h1 'Tutorial App'" do
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
    background { visit help_path}
    scenario "have the h1 'Help'" do
      expect(page).to have_selector('h1', 'Help')
    end

    scenario "have the title 'Help'" do
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  context "About Page" do
    background { visit about_path }
    scenario "have the h1 'About Us'" do
      expect(page).to have_selector('h1', 'About Us')
    end

    scenario "have the title 'About'" do
      expect(page).to have_title("#{base_title} | About")
    end
  end

  context "Contact Page" do
    background {visit contact_path}
    scenario "have the h1 'Contact Us'" do
      expect(page).to have_selector('h1', 'Contact Us')
    end

    scenario "have the title 'Contact'" do
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end
