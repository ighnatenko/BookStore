# frozen_string_literal: true

# AddressService
class AddressService
  attr_reader :billing_address, :shipping_address

  def initialize(current_user, params = nil)
    @params = params
    @user = current_user
    @billing_address = current_user_address(:billing)
    @shipping_address = current_user_address(:shipping)
  end

  def call
    if address_params[:address_type] == 'billing'
      create_or_update_billing_address
    else
      create_or_update_shipping_address
    end
    self
  end

  private

  def current_user_address(type)
    @user.addresses.find_or_initialize_by(address_type: type)
  end

  def create_or_update_billing_address
    address = @user.addresses.find_by(address_type: :billing)

    if address.nil?
      @billing_address = @user.addresses.create(address_params)
    else
      address.update(address_params)
      @billing_address = address
    end
  end

  def create_or_update_shipping_address
    address = @user.addresses.find_by(address_type: :shipping)

    if address.nil?
      @shipping_address = @user.addresses.create(address_params)
    else
      address.update(address_params)
      @shipping_address = address
    end
  end

  def address_params
    @params.require(:address).permit(:firstname, :lastname, :address, :city,
                                     :zipcode, :country, :phone, :address_type)
  end
end
