class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?

    if resource.persisted?
      @current_order.update(user: current_user)
      resource.active_for_authentication? ? successful_authentication : unsuccessful_authentication
    else
      handle_persisted_resource
    end
  end

  private

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