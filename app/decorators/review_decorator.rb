# frozen_string_literal: true

# ReviewDecorator
class ReviewDecorator < Draper::Decorator
  delegate_all

  def owner
    User.find(user_id)
  end
end
