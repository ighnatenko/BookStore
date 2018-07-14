# frozen_string_literal: true

# CustomerController
class CustomerController < ApplicationController
  def index; end

  def register
    password = Devise.friendly_token.first(8)
    @user = User.new(email: customer_params[:email], password: password,
                     password_confirmation: password)
    @user.skip_confirmation!
    @user.skip_reconfirmation!
    if @user.save
      sign_in(:user, @user)
      flash[:success] = t('devise.registrations.signed_up')
      redirect_to checkout_index_path
    else
      flash[:alert] = 'Please enter email'
      return redirect_to customer_index_path
    end
  end

  def login
    @user = User.find_by_email(customer_params[:email])
    if @user&.valid_password?(customer_params[:password])
      sign_in(:user, @user)
      flash[:success] = t('devise.sessions.signed_in')
      redirect_to checkout_index_path
    else
      flash[:alert] = t('devise.failure.not_found_in_database',
                        authentication_keys: customer_params[:email])
      redirect_to customer_index_path
    end
  end

  private

  def customer_params
    params.require(:user).permit(:email, :password)
  end
end
