class Release
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :display_name
  field :version
  field :notes
  field :extension

  belongs_to :product
  has_one :icon, dependent: :destroy

  before_create :associate_product
  after_save :update_product_timestamp

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

  def update_product_timestamp
    self.product.update_attribute(:updated_at, Time.now)
  end

end
