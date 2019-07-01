class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :confirmable
  include DeviseTokenAuth::Concerns::User

  enum gender: { female: 0, male: 1 }

  has_many :targets, dependent: :destroy

  validates :name, :gender, presence: true

  after_create :subscribe_user

  def targets_match
    targets.flat_map { |target| target.compatible_targets }
  end

  private

  def subscribe_user
    SubscribeUserJob.perform_now(self)
  end
end
