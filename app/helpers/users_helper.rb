module UsersHelper
  def gravatar_for user, options = {size: Settings.const.gravatar_default_size}
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "#{Settings.url.gravatar_url}#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def can_delete? user
    current_user.admin? && !current_user?(user)
  end
end
