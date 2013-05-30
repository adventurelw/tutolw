module UsersHelper
  #使用size默认参数而不是命名参数，以适应1.9的语法。
  def gravatar_for(user, size=50)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{ gravatar_id }.png?s=#{ size }"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
