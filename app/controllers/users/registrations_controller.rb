class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @billing_address = current_user_address(:billing)
    @shipping_address = current_user_address(:shipping)
    render :edit
  end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?

    if resource.persisted?
      @_current_order&.update(user: resource)
      resource.active_for_authentication? ? successful_authentication : unsuccessful_authentication
    else
      handle_persisted_resource
    end
  end

  protected

  def update_resource(resource, params)
    if params['password']&.present?
      result = super
      set_flash_message!(:alert, :password_error) unless result
      return result
    end
    resource.update_without_password(params.except('current_password'))
  end

  def current_user_address(type)
    current_user.addresses.find_or_initialize_by(address_type: type)
  end

  def handle_persisted_resource
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end

  def successful_authentication
    set_flash_message! :notice, :signed_up
    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  def unsuccessful_authentication
    set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    expire_data_after_sign_in!
    respond_with resource, location: after_inactive_sign_up_path_for(resource)
  end
end