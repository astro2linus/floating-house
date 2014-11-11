module ApplicationHelper
	def manifest_ipa_url(release)
		plist_url = manifest_url(release).sub('http', 'https')
    "itms-services://?action=download-manifest&url=#{CGI::escape(plist_url)}"
  end
end
