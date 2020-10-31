class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @time = Time.now
    @wages = Wage.where(params[user_id: @user.id])
  end

end
