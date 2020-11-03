class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wages = Wage.order(id: :DESC).where(user_id: @user.id)
    @jikan = Jikan.order(id: :DESC).find_by(user_id: @user.id)
    @comment = Comment.new
    @comments = Comment.order(id: :DESC).where(user_id: @user.id)
    
    if @jikan
      @last_day = "#{@jikan.created_at.strftime('%Y/%m/%d')}"
    end

    @time = Time.now
    if @time.day < 10
      day = "0#{@time.day}"
    else
      day = "#{@time.day}"
    end
    @today = "#{@time.year}/#{@time.month}/#{day}"
  
    if @user.wages != []
      @wage = @user.wages.find_by(jikan_id: @jikan.id)
    end
  end

end
