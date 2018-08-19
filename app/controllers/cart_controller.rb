# frozen_string_literal: true

# CartController
class CartController < ApplicationController
  authorize_resource :order, :book, :position
  before_action :set_order

  def index
    @items = @order.books
  end

  def add_item
    if @order.books.where(id: items_params[:book_id]).any?
      return redirect_to cart_path, alert: t('cart.alredy_added')
    end
    create_position
  end

  def destroy
    @order.books.delete(Book.find(params[:book_id]))
    redirect_to cart_path, notice: t('cart.removed')
  end

  def increment
    change_quantity(increment: true)
  end

  def decrement
    change_quantity(increment: false)
  end

  private

  def set_order
    @order = @current_order
  end

  def change_quantity(increment: true)
    ChangeQuantity.call(@order.id, params[:book_id], increment: increment) do
      on(:ok) { redirect_to cart_path }
    end
  end

  def items_params
    params.require(:items).permit(:price, :quantity, :book_id)
  end

  def create_position
    Position.create(order_id: @order.id, book_id: items_params[:book_id],
                    quantity: items_params[:quantity].to_i)
    redirect_to cart_path, notice: t('cart.successful_added')
  end
end
