require "test_helper"

class Merchants::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get best correspondence address for Merchant (UK)" do
    merchant = create(:merchant)
    create(:address, :registered, :uk, addressable: merchant, line_1: "Registered address 1", postcode: "AB10 1CD")
    create(:address, :shipping, :uk, addressable: merchant, line_1: "Shipping address 1", postcode: "AB12 3CD")
    create(:address, :billing, :uk, addressable: merchant, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Registered address 1"
  end

  test "should fall back on shipping address for Merchant if registered not deliverable (UK)" do
    merchant = create(:merchant)
    create(:address, :registered, :uk, addressable: merchant, line_1: "Registered address 1", postcode: "") # intentionally blank
    create(:address, :shipping, :uk, addressable: merchant, line_1: "Shipping address 1", postcode: "AB12 3CD")
    create(:address, :billing, :uk, addressable: merchant, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should fall back on billing address for Merchant if registered and shipping not deliverable (UK)" do
    merchant = create(:merchant)

    create(:address, :registered, :uk, addressable: merchant, line_1: "Registered address 1", postcode: "") # intentionally blank
    create(:address, :shipping, :uk, addressable: merchant, line_1: "Shipping address 1", postcode: "") # intentionally blank
    create(:address, :billing, :uk, addressable: merchant, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Billing address 1"
  end

  test "should get best correspondence address for Merchant (Australia)" do
    merchant = create(:merchant)
    create(:address, :registered, :australia, addressable: merchant, line_1: "Registered address 1", postcode: "AB10 1CD")
    create(:address, :shipping, :australia, addressable: merchant, line_1: "Shipping address 1", postcode: "AB12 3CD")
    create(:address, :billing, :australia, addressable: merchant, line_1: "Billing address 1", postcode: "AB45 5XY")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Registered address 1"
  end

  test "should fall back on shipping address for Merchant if registered not deliverable (Australia)" do
    merchant = create(:merchant)
    create(:address, :registered, :australia, addressable: merchant, line_1: "Registered address 1", postcode: "") # postcode blank
    create(:address, :shipping, :australia, addressable: merchant, line_1: "Shipping address 1", postcode: "AB12 3CD")
    create(:address, :billing, :australia, addressable: merchant, line_1: "Billing address 1", postcode: "AB45 5XY")


    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should respond 404 if no address is present" do
    merchant = create(:merchant)

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end

  test "should respond 404 if no address is deliverable" do
    merchant = create(:merchant)
    create(:address, :registered, :uk, addressable: merchant, line_1: "", postcode: "")
    create(:address, :shipping, :uk, addressable: merchant, line_1: "", postcode: "")
    create(:address, :billing, :uk, addressable: merchant, line_1: "", postcode: "")


    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end
end
