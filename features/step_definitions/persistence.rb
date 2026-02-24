# features/step_definitions/user_steps.rb
Given('the {string} memory store is cleared') do |resource_name|
  res = @http.post_json("/test_support/resources/#{resource_name}/reset", {})
  raise "reset failed: #{res[:status]} #{res[:raw_body]}" unless res[:status] == 204
end

When("I request the user JSON:API document for the created user") do
  @last_response = @http.get("/test_support/#{@created_user_id}")
end

When('I request the user JSON:API document for user id "{string}"') do |id|
  @last_response = @http.get("/users/#{id}")
end
