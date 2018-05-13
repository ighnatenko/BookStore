module CurrentOrder
  extend ActiveSupport::Concern

  included do

    def present_order
      @_current_order ||= order_from_session || order_from_current_user

      unless @_current_order&.in_progress? 
        @_current_order = new_order
      end

      if @_current_order == nil
        @_current_order = new_order
      end
    end
  
    private
  
    def order_from_current_user
      current_user&.orders&.find_by(state: 'in_progress')
    end
  
    def order_from_session
      Order.find_by(id: session[:order_id])
    end
  
    def new_order
      order = Order.create(user: current_user)
      order.tracking_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
      order.save
      session[:order_id] = order.id
      order
    end
  end
end