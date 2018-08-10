# frozen_string_literal: true

# AddressesController
class AddressesController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :authenticate_user!

  def index
    @billing_form = AddressFieldsForm.from_model(address_with_type(:billing))
    @shipping_form = AddressFieldsForm.from_model(address_with_type(:shipping))
    render :edit
  end

  def create
    case address_params[:address_type]
    when 'billing' then update_billing_form
    when 'shipping' then update_shipping_form
    end
    render :edit
  end

  private

  def update_billing_form
    @shipping_form = AddressFieldsForm.from_model(address_with_type(:shipping))
    @billing_form = AddressFieldsForm.from_params(address_params)
    return unless @billing_form.valid?
    create_or_update_address(current_user, @billing_form)
  end

  def update_shipping_form
    @billing_form = AddressFieldsForm.from_model(address_with_type(:billing))
    @shipping_form = AddressFieldsForm.from_params(address_params)
    return unless @shipping_form.valid?
    create_or_update_address(current_user, @shipping_form)
  end

  def create_or_update_address(user, form_address)
    address = user.addresses.find_by_address_type(form_address.address_type)
    if address.nil?
      user.addresses.create(form_address.attributes)
    else
      address.update(form_address.attributes)
    end
  end

  def address_with_type(type)
    current_user.addresses.find_or_initialize_by(address_type: type)
  end

  def address_params
    params.require(:address_fields)
          .permit(:firstname, :lastname, :address, :city,
                  :zipcode, :country, :phone, :address_type)
  end
end
