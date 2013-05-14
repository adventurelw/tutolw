include ApplicationHelper

#for spec/features
def valid_sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "登录"

  #Sign in when not use Capybara as well
  #在features中不能使用cookies，因为不是rails默认测试块
  #cookies[:remember_token] = user.remember_token
end

def invalid_sign_in
  visit signin_path
  click_button "登录"
end

def sign_out
  click_link "退出"
end

def fill_in_valid_information_for_sign_up
  fill_in "用户名", with: "Lavin"
  fill_in "邮箱", with: "lavin@gmail.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

#for all
Rspec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector("div.alert.alert-error", text: message)
  end
end

Rspec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector("div.alert.alert-success", text: message)
  end
end
