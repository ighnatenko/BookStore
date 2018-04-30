class CartController < ApplicationController
  def index
    redirect_to root_path, notice: "Index Cart"
  end

  def add_item
    redirect_to root_path, notice: 'Add Item'
  end

  private

  def cart_items_params
    params.require(:items).permit(:price, :quantity, :book_id)
  end

  def increment

  end

  def decrement

  end
end
