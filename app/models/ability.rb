# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can %i[read create update confirm], Order, user_id: user.id
    can :read, [Author, Book, Category, Review]
    can %i[read create update], Delivery
    can %i[read create update], CreditCard, user_id: user.id
    can %i[read create update], Address, addressable_type: 'User',
                                         addressable_id: user.id

    return unless user.confirmed_at
    can :create, Review, user_id: user.id

    return unless user.admin
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
  end
end
