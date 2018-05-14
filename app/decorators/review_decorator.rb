class ReviewDecorator < Draper::Decorator
  delegate_all

  def owner
    User.find_by(id: user_id)
  end
end
