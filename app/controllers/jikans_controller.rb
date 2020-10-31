class JikansController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = User.all
    @jikan = Jikan.new
    @time = Time.now
  end

  def show
    @users = User.all
    @jikan = Jikan.find(params[:id])
    @time = Time.now
    @end_time = @time.hour - @jikan.start_time
    @paying = @end_time * 1012 #横浜市最低賃金（令和2年10月1日）
    @wage = Wage.new
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