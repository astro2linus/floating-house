module ApplicationHelper
	def manifest_ipa_url(release)
		plist_url = manifest_url(release).sub('http', 'https')
		"itms-services://?action=download-manifest&url=#{plist_url}"
  end

  def gravatar(user = current_user, size = 32)
    Gravatar.new(user.email).image_url(size: size, default: :wavatar)
  end

  def download_or_install_link(release)
    if release.extension == "ipa"
      "itms-services://?action=download-manifest&url=#{manifest_ipa_url(release)}"
    elsif release.extension == "zip"
      download_release_url(release)
    elsif release.extension == "apk"
      download_release_url(release)
    end
  end

  def release_icon(release)
    case release.class
    when IosRelease
      content_tag(:img, nil, {src: asset_path('apple-icon.png'), class: 'release-icon'})
    when AndroidRelease
      content_tag(:img, nil, {src: asset_path('android-icon.png'), class: 'release-icon'})
    end
  end
end
