class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /trips
  # GET /trips.json
  def index
    if params[:user_id]
      @trips = User.find(params[:user_id]).trips
    elsif params[:group_id]
      @trips = Group.find(params[:group_id]).trips.unfinished
    else
      @trips = Trip.all      
    end

    render json: @trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    render json: @trip
  end

  # POST /trips
  # POST /trips.json
  def create
    if params[:user_id]
      params[:trip][:user_id] = params[:user_id]
    end

    @trip = Trip.new(trip_params)
    if @trip.save
      render json: @trip, status: :created, location: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])

    if @trip.update(trip_params)
      head :no_content
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy

    head :no_content
  end

  private

    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:user_id, {:group_ids => []}, :start_latitude, :start_longitude, :end_latitude, :end_longitude, :end_time)
    end
end
