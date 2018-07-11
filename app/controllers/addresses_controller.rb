class AddressesController < ApplicationController
  load_resource

  def create
    @address = current_user.addresses.create(address_params)
    show_flash(:create)
    redirect_to edit_user_registration_path
  end

  def update
    @address.update(address_params)
    show_flash(:update)
    redirect_to edit_user_registration_path
  end

  private
  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zipcode, :country, :phone, :address_type)
  end

  def show_flash(action)
    @address.errors.any? ? flash[:alert] = t("address.failure.#{action}") : flash[:notice] = t("address.successful.#{action}")
  end
end