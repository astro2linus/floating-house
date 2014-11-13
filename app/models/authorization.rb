class Authorization
  include Mongoid::Document

  field :provider, type: String
  field :uid, type: String

  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: [:provider] }

  class << self
  	def find_by_auth(auth)
  		where(provider: auth['provider'], uid: auth['uid']).first
  	end

  	def build_by_auth(auth)
  		new(provider: auth['provider'], uid: auth['uid'])
  	end

  end
end
