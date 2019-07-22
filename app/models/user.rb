# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string           not null
#  nickname               :string
#  image                  :string
#  email                  :string
#  tokens                 :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  gender                 :integer          not null
#  id_onesignal           :string
#

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
  has_many :conversations_users
  has_many :conversations, through: :conversations_users

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
