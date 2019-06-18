class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum gender: { female: 0, male: 1 }

  has_many :targets, dependent: :destroy

  validates :name, :gender, presence: true
end
