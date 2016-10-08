class EventCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  # before_action :comment ,:only =>[:new, :create]

  def create
    @comment = @event.comments.build(params_comment)
    @comment.user = current_user

    if @comment.save
      flash[:notice]="留言成功"
    else
      flash[:alert]="留言失敗"
    end
    redirect_to event_path(@event)
  end
  def destroy
    @comment = @event.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
    else
      flash[:alert]="沒有權限"
    end
      redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  # def comment
  #   @comment = @event.comments.build
  # end

  def params_comment
    params.require(:comment).permit(:content,:event_id, :id,:user_id)
  end
end
