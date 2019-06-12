class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :targets, length: {
    maximum: 10,
    message: 'A user can only have a maximum of 10 targets'
  }

  has_many :targets,  dependent: :destroy
  
end