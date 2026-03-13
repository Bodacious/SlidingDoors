require "test_helper"

class Merchants::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get best correspondence address for Merchant (UK)" do
    merchant = create(:merchant,
                             # Return the registered address
                             registered_address_line_1: "Registered address 1",
                             registered_address_postcode: "AB12 3CD",
                             # Do not return the shipping address
                             shipping_address_line_1: "Shipping address 1",
                             shipping_address_postcode: "AB45 5XY",
                             # Do not return the billing address
                             billing_address_line_1: "Billing address 1",
                             billing_address_postcode: "AB67 8YZ")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Registered address 1"
  end

  test "should fall back on shipping address for Merchant if registered not deliverable (UK)" do
    merchant = create(:merchant,
                  # Do not return the registered address
                  registered_address_line_1: "Registered address 1",
                  registered_address_postcode: "", # intentionally blank
                  # Return the shipping address
                  shipping_address_line_1: "Shipping address 1",
                  shipping_address_postcode: "AB45 5XY",
                  # Do not return the billing address
                  billing_address_line_1: "Billing address 1",
                  billing_address_postcode: "AB67 8YZ")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should fall back on billing address for Merchant if registered and shipping not deliverable (UK)" do
    merchant = create(:merchant,
                  # Do not return the registered address
                  registered_address_line_1: "Registered address 1",
                  registered_address_postcode: "", # intentionally blank
                  # Do not return the shipping address
                  shipping_address_line_1: "Shipping address 1",
                  shipping_address_postcode: "", # intentionally blank
                  # Return the billing address
                  billing_address_line_1: "Billing address 1",
                  billing_address_postcode: "AB67 8YZ")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Billing address 1"
  end

  test "should get best correspondence address for Merchant (Australia)" do
    merchant = create(:merchant,
                  # Return the registered address
                  registered_address_line_1: "Registered address 1",
                  registered_address_line_2: "Suite 1",
                  registered_address_postcode: "2001",
                  registered_address_county: "NSW",
                  registered_address_country: "Australia",
                  # Do not return the shipping address
                  shipping_address_line_1: "Shipping address 1",
                  shipping_address_postcode: "AB45 5XY")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Registered address 1"
  end

  test "should fall back on shipping address for Merchant if registered not deliverable (Australia)" do
    merchant = create(:merchant,
                  # Do not return the registered address
                  registered_address_line_1: "Registered address 1",
                  registered_address_line_2: "", # intentionally blank
                  registered_address_postcode: "2001",
                  registered_address_county: "",
                  registered_address_country: "Australia",
                  # Return the shipping address
                  shipping_address_line_1: "Shipping address 1",
                  shipping_address_line_2: "Suburbia",
                  shipping_address_postcode: "3001",
                  shipping_address_county: "Victoria",
                  shipping_address_country: "Australia",
                  # Do not return the billing address
                  billing_address_line_1: "Billing address 1",
                  billing_address_postcode: "4001")

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :success
    assert_includes response.body, "Shipping address 1"
  end

  test "should respond 404 if no address is deliverable" do
    merchant = create(:merchant,
                  registered_address_line_1: "",
                  registered_address_postcode: "",
                  registered_address_country: "United Kingdom",
                  shipping_address_line_1: "",
                  shipping_address_postcode: "",
                  shipping_address_country: "United Kingdom",
                  billing_address_line_1: "",
                  billing_address_postcode: "",
                  billing_address_country: "United Kingdom",)

    get "/merchants/#{merchant.id}/addresses/correspondence"

    assert_response :not_found
    assert_includes response.body, "Error:"
  end
end
