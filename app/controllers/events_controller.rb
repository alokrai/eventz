# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
    @likers = @event.likers
    if current_user
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    @event.update(event_params)
    if @event.save
      redirect_to @event, notice: 'Event successfully created'
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to @event, notice: 'Event successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event)
          .permit(:name, :description, :location, :price, :starts_at, :image_file_name, :capacity)
  end
end
