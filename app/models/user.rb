class User < ApplicationRecord
	has_many :participations
	has_many :events, :through => :participations	
end
