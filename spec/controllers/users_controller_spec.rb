require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    {:name => 'Test User', :email => 'testmail@berkeley.edu', :password => '123456789Testing'}
  }

  let(:invalid_attributes) {
    {:name => 'Test User', :email => 'testmail@notberkeley.edu'}
  }

  let(:user) {
    User.create!( :name => 'Test User',
                  :email => 'testmail@berkeley.edu',
                  :password => '123456789Testing' )
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GroupsController. Be sure to keep this updated too.
  let(:valid_session) { user.create_new_auth_token }

  before(:each) do
    sign_in user
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, {:id => user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { :name => 'New Name', :email => 'newemail@berkeley.edu' }
      }

      it "updates the requested user" do
        put :update, {:id => user.to_param, :user => new_attributes}, valid_session
        user.reload
        expect(user.name).to eq('New Name')
        expect(user.email).to eq('newemail@berkeley.edu')
      end

      it "assigns the requested user as @user" do
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end
  end
end
