class EventsController < ApplicationController
before_action :authenticate_user!, :except =>[:index]
  def index
    @events = Event.all.page(params[:page]).per(10)
  end
  def new
    @event = Event.new
  end
  def create
    @event=Event.new(event_params)
    @event.user = current_user
    if @event.save
      flash[:notice]="新增成功"
      redirect_to events_path
    else
      flash[:alert]="新增失敗"
      render :action =>:new
    end
  end
  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
  end
  def edit
    @event = Event.find(params[:id])
    if @event.user == current_user
    else
      redirect_to event_path(@event)
      flash[:alert]="沒有權限"
    end

  end
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice]="修改成功"
      redirect_to events_path
    else
      render :action =>:edit
      flash[:alert]="修改失敗"
    end
  end
  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.destroy
      flash[:notice]="刪除成功"
      redirect_to events_path
    else
      redirect_to event_path(@event)
      flash[:alert]="沒有權限"
    end

  end
  private
  def event_params
    params.require(:event).permit(:name, :description, :category_id,:user_id)
  end
end
