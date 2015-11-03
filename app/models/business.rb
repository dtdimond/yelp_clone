class Business < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :picture_url
end