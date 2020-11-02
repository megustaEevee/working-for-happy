class JikansController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :today, only: [:index, :show]

  def index
    @users = User.all
    @jikan = Jikan.new

    if user_signed_in? 
      @jikan_last = Jikan.order(id: :DESC).find_by(user_id: current_user.id)
      return unless @jikan_last
      @last_day = "#{@jikan_last.created_at.strftime('%Y/%m/%d')}"
    end
  end

  def show
    @jikan = Jikan.find(params[:id])
    @last_day = "#{@jikan.created_at.strftime('%Y/%m/%d')}"
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

  def today
    @time = Time.now
    if @time.day < 10
      day = "0#{@time.day}"
    else
      day = "#{@time.day}"
    end
    @today = "#{@time.year}/#{@time.month}/#{day}"
  end

end