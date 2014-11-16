class Release
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :display_name
  field :version
  field :notes

  belongs_to :product
  has_one :icon, dependent: :destroy

  before_create :associate_product

  protected

  def associate_product
  	product = Product.find_or_initialize_by identifier: self.identifier
  	self.product = product
  	self.product.name = self.display_name if (self.product.name.blank? && !self.name.blank?)

  	if self.product.new_record?
  		self.product.releases << self
  		self.product.save!
  	end
  end

end
