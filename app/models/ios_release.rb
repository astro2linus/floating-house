class IosRelease < Release
  include Mongoid::Document

  field :ipa_file
  field :identifier
  #field :icon
  mount_uploader :ipa_file, ReleaseUploader
  #mount_uploader :icon, IconUploader
  before_save :load_details_from_ipa
  validates :ipa_file, presence: true

  def load_details_from_ipa
		ipa  = IPA::IPAFile.open(Rails.root.join('public', ipa_file.path).to_s)
		self.name =  ipa.name
		self.display_name = ipa.display_name || ipa.name || ipa.identifier || "No name"
		self.identifier = ipa.identifier
		self.version = ipa.version
    #icon = self.icons.new(:icon_data => IconStringIO.new("foobar.png", ipa.icon))
    icon = self.icons.new
    icon.image_data = ipa.icon unless ipa.icon.blank?
    icon.save!
	end
end