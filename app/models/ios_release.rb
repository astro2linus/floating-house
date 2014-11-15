class IosRelease < Release
  include Mongoid::Document
  field :ipa_file
  field :identifier
  mount_uploader :ipa_file, ReleaseUploader
  before_save :load_details_from_ipa
  validates :ipa_file, presence: true

  protected
  def load_details_from_ipa
		ipa  = IPA::IPAFile.open(Rails.root.join('public', ipa_file.path).to_s)
		self.name =  ipa.name
		self.display_name = ipa.display_name
		self.identifier = ipa.identifier
		self.version = ipa.version
	end
end
