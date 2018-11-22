module UsersHelper

  # Returns the Gravatar for the given user
  def gravatar_for(user, size: 80)
    puts "getting gravatar for '#{user.email}'', size=#{size}"
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    puts "url=#{gravatar_url}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
