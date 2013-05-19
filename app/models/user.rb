class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[\w+\-.]+@((?:[a-z\d\-]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:messages] || 'is not a email')
    end
  end
end

class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_secure_password

  has_many :microposts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true,
                    email: true,
                    uniqueness:{ case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { self.email.downcase! }
  before_save :create_remember_token

  def feed
    Micropost.where(user_id: id)
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
