class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  enum gender: { female: 0, male: 1 }

  has_many :targets, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, :gender, presence: true

  after_create :subscribe_user

  def targets_match
    targets.flat_map(&:compatible_targets)
  end

  def self.from_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
      user.confirm
    end
  end

  private

  def subscribe_user
    SubscribeUserJob.perform_later(self)
  end
end
