class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :identifier
  field :description
  field :icon
  mount_uploader :icon, IconUploader

  has_many :releases, dependent: :destroy
end
