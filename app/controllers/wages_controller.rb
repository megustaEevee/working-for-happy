class WagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @time = Time.now
    @wage = Wage.find(params[:id])
  end

  def create
    @wage = Wage.new(wage_params)
    if @wage.save
      redirect_to jikan_wage_path(id: @wage.id)
    end
  end

  def wage_params
    params.require(:wage ).permit(:end_time, :paying).merge(user_id: current_user.id, jikan_id: params[:jikan_id])
  end

end