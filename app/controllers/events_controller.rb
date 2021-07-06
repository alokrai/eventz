# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    case params[:filter]
    when 'past'
      @events = Event.past
    when 'free'
      @events = Event.free
    when 'recent'
      @events = Event.recent
    else
      @events = Event.upcoming
    end
  end

  def show
    @likers = @event.likers
    @categories = @event.categories
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
  end

  def update
    @event.update(event_params)
    if @event.save
      redirect_to @event, notice: 'Event successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event)
          .permit(:name,
                  :description,
                  :location,
                  :price,
                  :starts_at,
                  :image_file_name,
                  :capacity,
                  category_ids: [])
  end

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end
end
