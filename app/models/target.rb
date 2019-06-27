class Target < ApplicationRecord
  acts_as_mappable  default_units: :km,
                    default_formula: :flat,
                    distance_field_name: :distance,
                    lat_column_name: :latitude,
                    lng_column_name: :longitude

  enum topic: { football: 0, travel: 1, politics: 2, art: 3, dating: 4, music: 5, movies: 6, series: 7, food: 8 }

  belongs_to :user

  validates :title, length: { maximum: 140 }, uniqueness: { case_sensitive: false }, presence: true
  validates :topic, :length, :latitude, :longitude, presence: true
  validate  :target_maximum, on: :create

  after_create :send_notify

  def compatible_targets
    Target.where.not(user_id: user_id).where(topic: topic).select do |target|
      target.distance_to(self) * 1000 <= (target.length + length)
    end
  end

  private

  def send_notify
    NotifyCompatiblesJob.perform_later(self)
  end

  def target_maximum
    if user.targets.length > 9
      errors.add(:target_maximum, I18n.t('api.errors.maximum_reached'))
    end
  end
end
