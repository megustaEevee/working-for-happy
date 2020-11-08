class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to work_path(@comment.work.id)
    else
      @time = Time.now
      @work = @comment.work
      @wage = Wage.new
      render 'works/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, work_id: params[:work_id])
  end
end
