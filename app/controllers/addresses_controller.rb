# frozen_string_literal: true

# AddressesController
class AddressesController < ApplicationController
  before_action :authenticate_user!

  def index
    @address_service = AddressService.new(current_user)
    render :edit
  end

  def create
    @address_service = AddressService.new(current_user, params).call
    render :edit
  end
end
