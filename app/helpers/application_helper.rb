module ApplicationHelper
	def manifest_ipa_url(release)
		plist_url = manifest_url(release).sub('http', 'https')
    "itms-services://?action=download-manifest&url=#{CGI::escape(plist_url)}"
  end

  def gravatar(user = current_user, size = 32)
    Gravatar.new(user.email).image_url(size: size, default: :wavatar)
  end
end
