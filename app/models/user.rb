class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :confirmable
  include DeviseTokenAuth::Concerns::User

  before_create :create_onesignal

  enum gender: { female: 0, male: 1 }

  has_many :targets, dependent: :destroy

  validates :name, :gender, presence: true

  def targets_match
    targets.flat_map { |target| target.compatible_targets }
  end

  private

  def create_onesignal    
    self.id_onesignal=NotifyCompatible.create_user(self.email)
  end
end
