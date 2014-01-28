class ChildProfile < ActiveRecord::Base
  attr_accessible :name,:dob,:gender,:status, :child_brewing_preference_attributes

  belongs_to :parent_profile
  has_one :child_brewing_preference
  has_many :pictures
  has_many :child_stats

  accepts_nested_attributes_for :child_brewing_preference
  #accepts_nested_attributes_for :pictures
  has_many :logbooks
  has_many :diaries
end
