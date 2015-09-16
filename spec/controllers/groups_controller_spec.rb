require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

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

  let(:valid_attributes) {
    {:name => 'Group Name'}
  }

  let(:invalid_attributes) {
    {:name => 'invalid@group.name'}
  }

  describe "GET #index" do
    it "assigns all groups as @groups" do
      group = Group.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe "GET #show" do
    it "assigns the requested group as @group" do
      group = Group.create! valid_attributes
      get :show, {:id => group.to_param}, valid_session
      expect(assigns(:group)).to eq(group)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, {:group => valid_attributes}, valid_session
        }.to change(Group, :count).by(1)
      end

      it "assigns a newly created group as @group" do
        post :create, {:group => valid_attributes}, valid_session
        expect(assigns(:group)).to be_a(Group)
        expect(assigns(:group)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved group as @group" do
        post :create, {:group => invalid_attributes}, valid_session
        expect(assigns(:group)).to be_a_new(Group)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before(:each) do
        User.create(:name => 'Naseem', :email => 'testemail1@berkeley.edu')
        User.create(:name => 'Naseem', :email => 'testemail2@berkeley.edu')
        User.create(:name => 'Naseem', :email => 'testemail3@berkeley.edu')
      end

      after(:each) do
        User.destroy_all
      end

      let(:new_attributes) {
        { :name => 'New Name' , :user_ids => [1, 2, 3] }
      }

      it "updates the requested group" do
        group = Group.create! valid_attributes
        put :update, {:id => group.to_param, :group => new_attributes}, valid_session
        group.reload
        expect(group.name).to eq('New Name')
        expect(group.user_ids).to eq([1, 2, 3])
      end

      it "assigns the requested group as @group" do
        group = Group.create! valid_attributes
        put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
        expect(assigns(:group)).to eq(group)
      end
    end

    context "with invalid params" do
      it "assigns the group as @group" do
        group = Group.create! valid_attributes
        put :update, {:id => group.to_param, :group => invalid_attributes}, valid_session
        expect(assigns(:group)).to eq(group)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group" do
      group = Group.create! valid_attributes
      expect {
        delete :destroy, {:id => group.to_param}, valid_session
      }.to change(Group, :count).by(-1)
    end
  end
end
