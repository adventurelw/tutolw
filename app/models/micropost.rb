class Micropost < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  default_scope order: 'microposts.created_at DESC'

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
