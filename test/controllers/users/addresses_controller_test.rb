require "test_helper"

class Users::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get best correspondence address for User" do
    user = FactoryBot.create(:user, shipping_address_line_1: "Shipping address 1")
    get "/users/#{user.id}/addresses/correspondence"
    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end
end
