class AndroidRelease < Release
  include Mongoid::Document

  field :apk_file
  field :identifier

  mount_uploader :apk_file, ReleaseUploader
  before_save :load_details_from_apk
  validates :apk_file, presence: true

  def load_details_from_apk
    apk = Android::Apk.new(Rails.root.join('public', apk_file.path).to_s)
    data = Hash.from_xml(apk.manifest.to_xml)

    self.identifier = data["manifest"]["package"]
    self.version =  data["manifest"]["android:versionName"]
    self.display_name = apk.manifest.label
    self.name = apk.manifest.label
  end
end