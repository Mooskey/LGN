class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :delete, :going, :toggle_host, :destroy]
  before_filter :only_host, only: [:edit, :update, :delete, :toggle_host, :destroy]
  before_action :set_user, only: [:toggle_host, :ensure]
  before_action :ensure_host, only: [:toggle_host]


  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        @event.users << current_user
          if @event.events_users.first.user_id == current_user.id
             @event.events_users.first.update(is_host: true)
          end
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  def going
    if @event.users.include?(current_user)
        @event.users.delete(current_user)
    else
      @event.users << current_user
    end
    if @event.events_users.where(is_host: true) == []
        @event.delete
      redirect_to events_path
    else
      redirect_to @event
    end
  end

  def index
    # @eventss = Event.all
    @eventss = Event.near([current_user.latitude, current_user.longitude], 300) || Event.near(current_user.city, 300)

    @page = (params[:page] || 1).to_i
    skip = (@page - 1) * 10
    @events =   @eventss.
                order(created_at: :desc).
                limit(10).
                offset(skip).
                all
            if params[:page] != nil && params[:page].to_i < 1
              redirect_back fallback_location: events_path
            elsif ((@eventss.length/10.0).ceil && 1) < params[:page].to_i
              redirect_to "/events/page/#{(@eventss.length/10.0).ceil}"
            end

  end

  def show
  end

  def destroy
    @event.events_users.where(event_id: @event.id).delete_all
    @event.delete
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  def delete
    @event.events_users.where(event_id: @event.id).delete_all
    @event.delete
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def toggle_host
    #check for input
    if @user
      #set user to toggle to input
      new_host = @event.events_users.find_by(user_id: (@user.id))
      if new_host
        if new_host.is_host
          new_host.is_host = false
        else
          new_host.is_host = true
        end
        new_host.save
        if @event.events_users.where(is_host: true) == []
            @event.delete
          redirect_to events_path
        else
          redirect_to @event
        end
      else
        redirect_to @event
        flash[:notice] = "#{@user.username} isn't attending this event"
      end
    else
      redirect_to @event
      flash[:alert] = "You need to specify the user to hostify!"
    end
  end

  def update
  #if current_user is host
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

    private
  def event_params
    params.require(:event).permit(:name, :description, :date, :time, :address, :city, :state, :zip, :country)
  end
  def only_host
    unless @event.events_users.where(is_host: true, user_id: current_user.id).exists?
      redirect_to @event
      flash[:alert] = "You must be a host to do that"

    end
  end
  def ensure_host
    #if there is one host and
    if (@event.events_users.where(is_host: true).length ==1) && (current_user == @user)
      redirect_to @event
      flash[:alert] = "You can't delete the last host"
    end
  end
  def set_event
    @event = Event.find(params[:id])
  end
  def set_user
    @user = User.find_by(username: params[:username])
  end
end
