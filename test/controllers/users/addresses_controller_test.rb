require "test_helper"

class Users::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get best correspondence address for User (UK)" do
    user = create(:user)
    create(:address, :shipping, :uk, addressable: user, line_1: "Shipping address 1", postcode: "AB12 3CD")
    create(:address, :billing, :uk, addressable: user, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should fall back on business address for User if shipping not deliverable (UK)" do
    user = create(:user)
    create(:address, :shipping, :uk, addressable: user, line_1: "Shipping address 1", postcode: "") # postcode blank
    create(:address, :billing, :uk, addressable: user, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Billing address 1"
  end

  test "should get best correspondence address for User (Australia)" do
    user = create(:user)
    create(:address, :shipping, :australia, addressable: user, line_1: "Shipping address 1", postcode: "2000")
    create(:address, :billing, :australia, addressable: user, line_1: "Billing address 1", postcode: "3000")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should fall back on business address for User if shipping not deliverable (Australia)" do
    user = create(:user)
    create(:address, :shipping, :australia, addressable: user, line_1: "Shipping address 1", postcode: "2000", county: "", country: "Australia")
    create(:address, :billing, :australia, addressable: user, line_1: "Billing address 1", postcode: "3000", county: "Victoria", country: "Australia")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Billing address 1"
  end

  test "should respond 404 if neither address exists" do
    user = create(:user)

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end

  test "should respond 404 if neither address is deliverable" do
    user = create(:user)
    create(:address, :shipping, :uk, addressable: user, line_1: "", postcode: "")
    create(:address, :billing, :uk, addressable: user, line_1: "", postcode: "")

    get "/users/#{user.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end
end
