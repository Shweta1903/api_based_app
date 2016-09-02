class City < ActiveRecord::Base
  belongs_to :state
  has_many :pins
end
