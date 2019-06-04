# frozen_string_literal: true

class User < ActiveRecord::Base

  # lo tuve que agregar a mano
  #extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  
end
