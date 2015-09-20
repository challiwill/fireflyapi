class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :latitude, :longitude, :group_ids => [])
    end
end
