class JikansController < ApplicationController
  def index
    @user = User.all
    @jikan = Jikan.new
    @time = Time.now
  end

  def show
    @user = User.all
    @time = Time.now
  end

  def create
    @jikan = Jikan.new(jikan_params)
    if @jikan.save
      redirect_to @jikan
    else
      render 'index'
    end
  end

  private

  def jikan_params
    params.require(:jikan).permit(:start_time).merge(user_id: current_user.id)
  end

end