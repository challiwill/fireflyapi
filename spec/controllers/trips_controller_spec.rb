require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  before(:each) do
    User.create(:name => 'Testname one', :email => 'test1@email.com')
    Group.create(:name => 'Testgroup one')
    Group.create(:name => 'Testgroup two')
  end
  
  after(:each) do
    User.destroy_all
    Group.destroy_all
  end
  let(:valid_attributes) {
    { :user_id => 1, :group_ids => [1, 2], :start_latitude => 0,
      :start_longitude => 0, :end_latitude => 1, :end_longitude => 1,
      :end_time => Time.now }
  }

  let(:invalid_attributes) {
    # Test without user_id
    { :group_ids => [1, 2], :start_latitude => 0,
      :start_longitude => 0, :end_latitude => 1, :end_longitude => 1,
      :end_time => Time.now }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TripsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all trips as @trips" do
      trip = Trip.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:trips)).to eq([trip])
    end
  end

  describe "GET #show" do
    it "assigns the requested trip as @trip" do
      trip = Trip.create! valid_attributes
      get :show, {:id => trip.to_param}, valid_session
      expect(assigns(:trip)).to eq(trip)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Trip" do
        expect {
          post :create, {:trip => valid_attributes}, valid_session
        }.to change(Trip, :count).by(1)
      end

      it "assigns a newly created trip as @trip" do
        post :create, {:trip => valid_attributes}, valid_session
        expect(assigns(:trip)).to be_a(Trip)
        expect(assigns(:trip)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved trip as @trip" do
        post :create, {:trip => invalid_attributes}, valid_session
        expect(assigns(:trip)).to be_a_new(Trip)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before(:each) do
        User.create(:name => 'Testname two', :email => 'test2@email.com')
        Group.create(:name => 'Testgroup three')
      end

      after(:each) do
        User.destroy_all
        Group.destroy_all
      end

      let(:new_attributes) {
        { :user_id => 2, :group_ids => [3], :start_latitude => 1,
          :start_longitude => 1, :end_latitude => 3, :end_longitude => 3,
          :end_time => Time.now }
      }

      it "updates the requested trip" do
        trip = Trip.create! valid_attributes
        old_time = trip.end_time
        put :update, {:id => trip.to_param, :trip => new_attributes}, valid_session
        trip.reload
        expect(trip.user_id).to eq(2)
        expect(trip.group_ids).to eq([3])
        expect(trip.start_latitude).to eq(1)
        expect(trip.start_longitude).to eq(1)
        expect(trip.end_latitude).to eq(3)
        expect(trip.end_longitude).to eq(3)
        expect(trip.end_time).to_not eq(old_time)
      end

      it "assigns the requested trip as @trip" do
        trip = Trip.create! valid_attributes
        put :update, {:id => trip.to_param, :trip => valid_attributes}, valid_session
        expect(assigns(:trip)).to eq(trip)
      end
    end

    context "with invalid params" do
      it "assigns the trip as @trip" do
        trip = Trip.create! valid_attributes
        put :update, {:id => trip.to_param, :trip => invalid_attributes}, valid_session
        expect(assigns(:trip)).to eq(trip)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested trip" do
      trip = Trip.create! valid_attributes
      expect {
        delete :destroy, {:id => trip.to_param}, valid_session
      }.to change(Trip, :count).by(-1)
    end
  end
end
