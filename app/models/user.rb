class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username, :type => String
  field :facebook_id, :type => String
  field :access_token, :type => String
  field :facebook, :type => Hash
  has_many :mentions
end
