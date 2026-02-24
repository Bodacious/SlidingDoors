require "test_helper"

class Users::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get correspondence" do
    get users_addresses_correspondence_url
    assert_response :success
  end
end
