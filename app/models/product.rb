class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :identifier
  field :description

  has_many :releases, dependent: :destroy
end
