require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { name: @group.name }
    end

    assert_response 201
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should update group" do
    put :update, id: @group, group: { name: @group.name }
    assert_response 204
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_response 204
  end
end
