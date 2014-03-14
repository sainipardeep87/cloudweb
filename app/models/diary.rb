class Diary < ActiveRecord::Base
    attr_accessible :log
    belongs_to :child_profile
    has_many :pictures
end
