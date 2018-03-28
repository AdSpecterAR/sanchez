class UsersController < ApplicationController
  # before_action :authenticate_user!

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: UserRepresenter.represent(@user) }
    else
      render json: { error: "error" }
    end
  end

  def index
    render json: { message: 'authenticated' }
  end

  protected

  def user_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :full_name,
        :account_type,
        :username,
        :email
      )
  end
end
