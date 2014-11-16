class Icon
  include Mongoid::Document
  include Mongoid::Timestamps

  field :icon_data

  belongs_to :release
  mount_uploader :icon_data, IconUploader

end
