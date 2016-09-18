class IosReleaseUploader < ReleaseUploader
  def extension_white_list
    %w(zip ipa)
  end
end