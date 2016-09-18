class AndroidReleaseUploader < ReleaseUploader
  def extension_white_list
    %w(apk)
  end
end