class Target < ApplicationRecord
  belongs_to :user  
  #validates :user_id, presence: true
  validates :title, length: { maximum: 140 },uniqueness: { case_sensitive: false }
  validates_presence_of :title, :topic, :length, :latitude, :longitude

  enum topic: [:football, :travel, :politics, :art, :dating, :music, :movies, :series, :food]
end
