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


  context 'for signed-in user' do
    given(:user) { FactoryGirl.create(:user) }
    background do
      FactoryGirl.create(:micropost, user: user, content: 'like you')
      valid_sign_in user
    end

    context "render user's feed" do
      context 'get correct microposts count' do
        it 'have 1 micropost' do
          visit root_path
          expect(page).to have_content('1 micropost')
        end

        it 'have 2 microposts' do
          FactoryGirl.create(:micropost, user: user, content: 'love you')
          visit root_path
          expect(page).to have_content('2 microposts')
        end
      end

      scenario 'have li#item.id content' do
        FactoryGirl.create(:micropost, user: user, content: 'love you')
        visit root_path
        user.feed.each do |item|
          expect(page).to have_selector("li##{ item.id }", text: item.content)
        end
      end
    end
  end
end
