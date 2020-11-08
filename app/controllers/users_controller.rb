class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wages = Wage.order(id: :DESC).where(user_id: @user.id)
    @work = Work.order(id: :DESC).find_by(user_id: @user.id)
    @comments = Comment.order(id: :DESC).where(user_id: @user.id)

    @last_day = @work.created_at.strftime('%Y/%m/%d').to_s if @work

    @time = Time.now
    day = if @time.day < 10
            "0#{@time.day}"
          else
            @time.day.to_s
          end
    @today = "#{@time.year}/#{@time.month}/#{day}"

    @wage = @user.wages.find_by(work_id: @work.id) if @user.wages != []
  end
end