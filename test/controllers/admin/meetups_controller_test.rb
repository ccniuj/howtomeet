require 'test_helper'

class Admin::MeetupsControllerTest < ActionController::TestCase
  setup do
    @admin_meetup = admin_meetups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_meetups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_meetup" do
    assert_difference('Admin::Meetup.count') do
      post :create, admin_meetup: {  }
    end

    assert_redirected_to admin_meetup_path(assigns(:admin_meetup))
  end

  test "should show admin_meetup" do
    get :show, id: @admin_meetup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_meetup
    assert_response :success
  end

  test "should update admin_meetup" do
    patch :update, id: @admin_meetup, admin_meetup: {  }
    assert_redirected_to admin_meetup_path(assigns(:admin_meetup))
  end

  test "should destroy admin_meetup" do
    assert_difference('Admin::Meetup.count', -1) do
      delete :destroy, id: @admin_meetup
    end

    assert_redirected_to admin_meetups_path
  end
end
