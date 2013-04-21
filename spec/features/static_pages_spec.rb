require 'spec_helper'

describe "StaticPages" do
  context "Home page" do
    it "should have content 'Tutorial App'" do
      visit '/static_pages/home'
      page.should have_content('Tutorial App')
    end
  end

  context "Help Page" do
    it "should have content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end

  context "About Page" do
    it "should have content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
  end
end
