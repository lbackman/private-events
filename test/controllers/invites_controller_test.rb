require "test_helper"

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get invites_new_url
    assert_response :success
  end

  test "should get create" do
    get invites_create_url
    assert_response :success
  end

  test "should get show" do
    get invites_show_url
    assert_response :success
  end

  test "should get edit" do
    get invites_edit_url
    assert_response :success
  end

  test "should get update" do
    get invites_update_url
    assert_response :success
  end

  test "should get destroy" do
    get invites_destroy_url
    assert_response :success
  end
end
