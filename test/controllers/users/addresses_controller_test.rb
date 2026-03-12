require "test_helper"

class Users::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get best correspondence address for User" do
    user = create(:user,
                             # Return the shipping address
                             shipping_address_line_1: "Shipping address 1",
                             shipping_address_postcode: "AB12 3CD",
                             # Do not return the billing address
                             billing_address_line_1: "Billing address 1",
                             billing_address_postcode: "AB45 5XY")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should fall back on business address for User if shipping not deliverable" do
    user = create(:user,
                  # Return the shipping address
                  shipping_address_line_1: "Shipping address 1",
                  shipping_address_postcode: "", #intentionally blank
                  # Do not return the billing address
                  billing_address_line_1: "Billing address 1",
                  billing_address_postcode: "AB45 5XY")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Billing address 1"
  end

  test "should respond 404 if neither address is deliverable" do
    user = create(:user,
                  shipping_address_line_1: "",
                  shipping_address_postcode: "",
                  billing_address_line_1: "",
                  billing_address_postcode: "")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end
end
