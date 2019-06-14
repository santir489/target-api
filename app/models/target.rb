class Target < ApplicationRecord
  enum topic: { football: 0, travel: 1, politics: 2, art: 3, dating: 4, music: 5, movies: 6, series: 7, food: 8 }
  
  belongs_to :user    
  
  validates :title, length: { maximum: 140 }, uniqueness: { case_sensitive: false }, presence: true
  validates :topic, :length, :latitude, :longitude, presence: true
  validate :target_maximum, on: :create

  private
  
  def target_maximum
    if user.targets.length > 9
      errors.add(:target_maximum, I18n.t('api.errors.maximum_reached'))
    end
  end  
end
