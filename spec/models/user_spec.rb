require 'spec_helper'

describe User do
  subject { User.new(name: "laiwei",
                     email: "adventurelw@gmail.com",
                     password: "foopassword",
                     password_confirmation: "foopassword") }

  context "attributes" do
    it "have 'name'" do
      expect(subject).to respond_to(:name)
    end

    it "have 'email'" do
      expect(subject).to respond_to(:email)
    end

    it "have 'password_digest'" do
      expect(subject).to respond_to(:password_digest)
    end

    it "have 'password'" do
      expect(subject).to respond_to(:password)
    end

    it "have 'password_confirmation'" do
      expect(subject).to respond_to(:password_confirmation)
    end

    it "have 'authenticate'" do
      expect(subject).to respond_to(:authenticate)
    end

    it "have 'remember_token'" do
      expect(subject).to respond_to(:remember_token)
    end
  end


  context "validates name attribute" do
    it "name is valid" do
      expect(subject).to be_valid
    end

    it "name is not present" do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it "name is too long" do
      subject.name = '赖' * 41
      expect(subject).to_not be_valid
    end
  end

  context "validates email attribute" do
    it "email is not present" do
      subject.email = ''
      expect(subject).to_not be_valid
    end

    it "email format is valid" do
      addrs = %w[user@foo.COM A_use_er@f.b.org first.last@foo.jp a+b@baz.cn]
      addrs.each do |addr|
        subject.email = addr
        expect(subject).to be_valid
      end
    end

    it "email format is invalid" do
      addrs = %w[user@foo,org user_at_foo.org example.user@foo.
                 foo@bar_baz.org foo @bar]
      addrs.each do |addr|
        subject.email = addr
        expect(subject).to_not be_valid
      end
    end

    it "email address is already taken" do
      #由于initialize_dup在2.0中变成私有了，所以下面代码暂时有误。
      #rails3.2.13已经修复
      #user_with_same_email = subject.dup
      user_with_same_email = User.new(name: "xx",
        password: "foobar", password_confirmation: "foobar")
      user_with_same_email.email = subject.email.upcase
      user_with_same_email.save

      expect(subject).to_not be_valid
    end
  end

  context "validates password attribute" do
    it "password is not present" do
      subject.password = subject.password_confirmation = ' '
      expect(subject).to_not be_valid
    end

    it "password doesn't match confirmation" do
      subject.password_confirmation = "mismatch"
      expect(subject).to_not be_valid
    end

    it "password confirmation is nil" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "password is too short" do
      subject.password = subject.password_confirmation = 'a' * 5
      expect(subject).to_not be_valid
    end
  end

  context "authenticate password" do
    before { subject.save }
    let(:found_user) { User.find_by_email(subject.email) }

    it "with valid password" do
      expect(subject).to eq(found_user.authenticate(subject.password))
    end

    it "with invalid password" do
      user_for_invalid_password = found_user.authenticate("invalid")
      expect(subject).to_not eq(user_for_invalid_password)
      expect(user_for_invalid_password).to be_false
    end
  end

  context "remember_token" do
    it "cannot be blank" do
      subject.save
      expect(subject.remember_token).to_not be_blank
    end
  end
end
