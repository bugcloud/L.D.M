class Mention
  include Mongoid::Document
  include Mongoid::Timestamps
  # venue_id will be defined by foursquare
  field :venue_id, :type => String
  field :text, :type => String
  index :venue_id
  belongs_to :user

  validates :venue_id, :presence => true
  validates :text, :presence => true

  scope :find_by_venue_id, lambda {|vid|
    where(:venue_id => vid).order_by(:created_at.desc)
  }
end
