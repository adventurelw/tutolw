require 'spec_helper'

feature "StaticPages" do
  shared_examples_for "all static pages" do
    scenario "have the h1'" do
      expect(page).to have_selector('h1', text: heading)
    end

    scenario "have the title'" do
      expect(page).to have_title(full_title(page_title))
    end
  end

  context "Home page" do
    background { visit root_path }
    given(:heading) { "Tutorial App" }
    given(:page_title) { '' }
    it_behaves_like "all static pages"

    scenario "have not a custom title" do
      expect(page).to_not have_title("| Home")
    end

    scenario "have the right link on the layout" do
      click_link "About"
      expect(page).to have_title(full_title("About"))

      click_link "Help"
      expect(page).to have_title(full_title("Help"))

      click_link "Contact"
      expect(page).to have_title(full_title("Contact"))

      click_link "Home"
      expect(page).to have_title(full_title(''))

      click_link "Sign up"
      expect(page).to have_title(full_title("Sign up"))
    end
   end

  context "Help Page" do
    background { visit help_path }
    given(:heading) { "Help" }
    given(:page_title) { 'Help' }
    it_behaves_like "all static pages"
  end

  context "About Page" do
    background { visit about_path }
    given(:heading) { 'About Us' }
    given(:page_title) { 'About' }
    it_behaves_like "all static pages"
  end

  context "Contact Page" do
    background {visit contact_path}
    given(:heading) { 'Contact Us' }
    given(:page_title) { 'Contact' }
    it_behaves_like "all static pages"
  end
end
