class WagesController < ApplicationController
  before_action :authenticate_user!
  before_action :today, only: [:show, :create]

  def show
    @wage = Wage.find(params[:id])
  end

  def create
    @wage = Wage.new(wage_params)
    if @wage.save
      redirect_to work_wage_path(id: @wage.id)
    else
      @work = Work.find(params[:work_id])
      @comment = Comment.new
      render 'works/show'
    end
  end

  private

  def wage_params
    params.require(:wage).permit(:end_time, :paying).merge(user_id: current_user.id, work_id: params[:work_id])
  end

  def today
    @time = Time.now
  end
end
