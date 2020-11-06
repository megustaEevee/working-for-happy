class CommentsController < ApplicationController
  before_action :today, only: :create

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to work_path(@comment.work.id)
    else
      @work = @comment.work
      @wage = Wage.new
      render template: "works/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, work_id: params[:work_id])
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
