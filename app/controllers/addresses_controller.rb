class AddressesController < ApplicationController
  load_resource

  def create
    @address = current_user.addresses.create(address_params)
    show_errors
    redirect_to edit_user_registration_path
  end

  def update
    @address.update(address_params)
    show_errors
    redirect_to edit_user_registration_path
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zipcode, :country, :phone, :address_type)
  end

  def show_errors
    @address.errors.any? ? flash[:alert] = 'Failure' : flash[:notice] = 'Success'
  end
end
