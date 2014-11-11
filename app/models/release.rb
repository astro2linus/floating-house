class Release
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :version
  field :notes

end
