class EventsController < ApplicationController
before_action :authenticate_user!
  def index
    @events = Event.all
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
      render :action =>:new
      flash[:alert]="新增失敗"
    end
  end
  def show
    @event = Event.find(params[:id])
  end
  def edit
    @event = Event.find(params[:id])
    @event.user = current_user
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
    @event.destroy
    redirect_to events_path
  end
  private
  def event_params
    params.require(:event).permit(:name, :description, :category_id,:user_id)
  end
end
