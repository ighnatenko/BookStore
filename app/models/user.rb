# frozen_string_literal: true

# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.new_with_session(params, session)
    super.tap do |user|
      data = session['devise.facebook_data'] &&
             session['devise.facebook_data']['extra']['raw_info']
      if data
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.skip_confirmation!
    end
  end
end
