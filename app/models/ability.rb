# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can %i[read confirm], Order, user_id: user.id

    if user.admin
      init_admin_ability(user)
    elsif user.confirmed_at
      init_confirmed_user_ability(user)
    end
  end

  def init_admin_ability(user)
    can :access, :rails_admin
    can :manage, [Author, Book, Category]
    can :manage, User, id: user.id
    can %i[read create], Review, user_id: user.id
    can %i[read update], Order
    can %i[read create update], Address, addressable_type: 'User',
                                         addressable_id: user.id
    can %i[read create update], CreditCard, user_id: user.id
    can %i[read create update], Delivery, user_id: user.id
  end

  def init_confirmed_user_ability(user)
    can %i[read create update], Order, user_id: user.id
    can :read, [Author, Book, Category, Review]
    can :create, Review, user_id: user.id
    can %i[read create update], Delivery, user_id: user.id
    can %i[read create update], CreditCard, user_id: user.id
    can %i[read create update], Address, addressable_type: 'User',
                                         addressable_id: user.id
  end
end
