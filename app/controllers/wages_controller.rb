class WagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @time = Time.now
    @wage = Wage.find(params[:id])
  end

  def create
    @wage = Wage.new(wage_params)
    redirect_to work_wage_path(id: @wage.id) if @wage.save
  end

  private

  def wage_params
    params.require(:wage).permit(:end_time, :paying).merge(user_id: current_user.id, work_id: params[:work_id])
  end
end
