class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[\w+\-.]+@((?:[a-z\d\-]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:messages] || 'is not a email')
    end
  end
end

class User < ActiveRecord::Base
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id',
                                   class_name: 'Relationship',
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships,
                       source: :follower

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true,
                    email: true,
                    uniqueness:{ case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { self.email.downcase! }
  before_create :create_remember_token

  def feed
    Micropost.from_users_followed_by(self)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
