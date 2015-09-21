require 'rails_helper'

RSpec.describe "Trips", type: :request do

  describe "When user is signed in" do
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
      # We action the login request using the parameters before we begin.
      # The login requests will match these to the user we just created in the factory, and authenticate us.
      post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
    end

    describe "GET /trips" do
      it "Get all trips works" do
        get trips_path valid_session
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "When user is not signed in" do
    describe "GET /trips" do
      it "Get all trips returns unauthorized" do
        get trips_path 
        expect(response).to have_http_status(401)
      end
    end
  end
end
