# features/step_definitions/user_steps.rb
Given('I create a {string} resource via the API with:') do |resource_name, table|
  attrs = table.rows_hash.transform_keys(&:to_s)

  # Assumes your app exposes a test-only create endpoint that calls:
  #   STORE.create!(resource_name, attrs)
  #
  # Proposed endpoint:
  #   POST /test_support/resources/:resource_name
  #   body: { "attributes": { ... } }
  res = @http.post_json("/test_support/resources/#{resource_name}", { "attributes" => attrs })
  raise "create failed: #{res[:status]} #{res[:raw_body]}" unless res[:status] == 201

  @created_user_id = res[:body].fetch("id")
end

When("I request the user JSON for the created user") do
  @last_response = @http.get("/users/#{@created_user_id}")
end

When('I request the user JSON for user id {string}"') do |id|
  @last_response = @http.get("/users/#{id}")
end

Then("the response status should be {int}") do |expected|
  actual = @last_response.fetch(:status)
  raise "expected #{expected}, got #{actual}: #{@last_response[:raw_body]}" unless actual == expected
end
