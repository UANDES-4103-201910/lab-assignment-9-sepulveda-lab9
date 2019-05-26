class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.create
  end

  def update
    #complete this method
  end

  def destroy
    #complete this method
  end


end
