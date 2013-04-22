require 'spec_helper'

describe "StaticPages" do
  context "Home page" do
    it "should have content 'Tutorial App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', 'Tutorial App')
    end

    it "should have the right title" do
      visit "/static_pages/home"
      page.should have_title("Ruby on Rails Tutorial App | Home")
    end
  end

  context "Help Page" do
    it "should have content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', 'Help')
    end

    it "should have the right title" do
      visit "/static_pages/help"
      page.should have_title("Ruby on Rails Tutorial App | Help")
    end
  end

  context "About Page" do
    it "should have content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', 'About Us')
    end

    it "should have the right title" do
      visit "/static_pages/about"
      page.should have_title("Ruby on Rails Tutorial App | About")
    end
  end
end
