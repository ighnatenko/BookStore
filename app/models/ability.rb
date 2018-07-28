# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.admin
      init_admin_ability
    elsif user.confirmed_at
      init_confirmed_user_ability(user)
    end
  end

  def init_admin_ability
    can :access, :rails_admin
    can :manage, :all
  end

  def init_confirmed_user_ability(user)
    can :create, Review, user_id: user.id
    can %i[create update], Address, addressable_type: 'User',
                                    addressable_id: user.id
  end
end
