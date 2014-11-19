class User
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  field :name, type: String
  field :email, type: String

  has_many :authorizations, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  class << self

	  def build_by_auth(auth)
	  	info = auth['info'] || {}
	  	User.new name: info['name'], email: info['email']
	  end

	  def find_or_create_by_auth(auth)
	  	find_by_auth(auth) || create_by_auth(auth)
	  end

	  def find_by_auth(auth)
	  	user = find_by_auth_through_authorizations(auth) ||
	  				 find_by_auth_through_email(auth)
	  end

	  def create_by_auth(auth)
	  	user = build_by_auth(auth)
	  	if user.save
	  		user.save_auth(auth)
	  		user
	  	end
	  end

	  private

	  def find_by_auth_through_authorizations(auth)
	  	if authorization = Authorization.find_by_auth(auth)
	  		authorization.user
	  	end
	  end

	  def find_by_auth_through_email(auth)
	  	if email = auth['info'].try(:[], 'email')
	  		if user = User.where(email: email).first
	  			user.save_auth(auth)
	  			user
	  		end
	  	end
	  end
	end

	def save_auth(auth)
  	self.authorizations << Authorization.build_by_auth(auth)
  end

end
