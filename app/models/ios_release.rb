class IosRelease < Release
  include Mongoid::Document

  field :ipa_file
  field :identifier
  mount_uploader :ipa_file, ReleaseUploader
  before_save :load_details_from_ipa
  validates :ipa_file, presence: true

  def load_details_from_ipa
    ipa  = IpaParser::IpaFile.new(Rails.root.join('public', ipa_file.path).to_s)
    self.name =  ipa.name
    self.display_name = ipa.display_name || ipa.name || ipa.identifier || "No name"
    self.identifier = ipa.identifier
    self.version = ipa.version
    self.icon = Icon.new

    unless ipa.icon.blank?
      File.open(Rails.root.join('tmp', 'icon.png'), 'wb') { |file| file.write(ipa.icon) }
      self.icon.icon_data = File.open(Rails.root.join('tmp', 'icon.png'))
    end
    self.icon.save!
  end
end