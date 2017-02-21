class UsersController < ApplicationController
  before_action :authenticate_user!, :authorize_teacher!
  after_action :verify_authorized


  def index
    @users = User.order(:email).all
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update user_params
      redirect_to users_path
    else
      flash.alert = @user.errors.to_a.join '. '
      render :edit
    end
  end

  private

  def authorize_teacher!
    authorize User
  end

  def user_params
    params.require(:user).permit(:teacher)
  end
end
