# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  # def initialize(user)
  #   user ||= User.new

  #   can :read, :all
  #   can %i[read create update confirm], Order, user_id: user.id
  #   can :read, [Author, Book, Category, Review]
  #   can %i[read create update], Delivery
  #   can %i[read create update], CreditCard, user_id: user.id
  #   can %i[read create update], Address, addressable_type: 'User',
  #                                        addressable_id: user.id

  #   return unless user.confirmed_at
  #   can :create, Review, user_id: user.id

  #   return unless user.admin
  #   can :access, :rails_admin
  #   can :dashboard
  #   can :manage, :all
  # end

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
