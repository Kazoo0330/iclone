class UsersController < ApplicationController
#  before_action :set_user, only: %i[show edit update destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
	if @user.save
	  redirect_to user_path(@user.id)
	else
	  render 'new'
	end
  end

  def update
    @user = User.find(params[:id])
	if @user.update(user_params)
	  redirect_to user_path(@user)
	else 
	  render :edit
	end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'ユーザー情報が削除されました。' }
      format.json { head :no_content }
    end
  end

  private
#    def set_user
#      @user = User.find(params[:id])
#    end

  def user_params
    params.require(:user).permit %i[
      name email password password_confirmation image image_cache
    ]
  end
end
