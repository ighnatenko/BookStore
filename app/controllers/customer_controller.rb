# frozen_string_literal: true

# CustomerController
class CustomerController < ApplicationController
  def index; end

  def login
    @user = User.find_by_email(customer_params[:email])
    if @user&.valid_password?(customer_params[:password])
      login_successfully(@user)
    else
      login_unsuccessfully(customer_params[:email])
    end
  end

  def register
    user = new_user
    user.persisted? ? register_successfully(user) : register_unsuccessfully
  end

  private

  def register_successfully(user)
    sign_in(:user, user)
    flash[:success] = t('devise.registrations.signed_up')
    redirect_to shopping_cart.checkout_index_path
  end

  def register_unsuccessfully
    flash[:alert] = t('customer.user_exist')
    redirect_to customer_index_path
  end

  def login_successfully(user)
    sign_in(:user, user)
    flash[:success] = t('devise.sessions.signed_in')
    redirect_to checkout_index_path
  end

  def login_unsuccessfully(email)
    flash[:alert] = t('devise.failure.not_found_in_database',
                      authentication_keys: email)
    redirect_to customer_index_path
  end

  def new_user
    password = Devise.friendly_token.first(8)
    user = User.create(email: customer_params[:email],
                       password: password,
                       password_confirmation: password,
                       confirmed_at: Time.now.utc)
    user
  end

  def customer_params
    params.require(:user).permit(:email, :password)
  end
end
