class WorksController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :today, only: [:index, :show]

  def index
    @users = User.all
    @work = Work.new

    if user_signed_in?
      @work_last = Work.order(id: :DESC).find_by(user_id: current_user.id)
      return unless @work_last

      @last_day = @work_last.created_at.strftime('%Y/%m/%d').to_s
    end
  end

  def show
    @work = Work.find(params[:id])

    @last_day = @work.created_at.strftime('%Y/%m/%d').to_s
    @end_time = @time.hour - @work.start_time
    @paying = @end_time * 1012 - 1012 # 横浜市最低賃金（令和2年10月1日）

    @comment = Comment.new
    @comments = @work.comments

    @wage = Wage.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to @work
    else
      render 'index'
    end
  end

  private

  def work_params
    params.require(:work).permit(:start_time).merge(user_id: current_user.id)
  end

  def today
    @time = Time.now
    day = if @time.day < 10
            "0#{@time.day}"
          else
            @time.day.to_s
          end
    @today = "#{@time.year}/#{@time.month}/#{day}"
  end
end