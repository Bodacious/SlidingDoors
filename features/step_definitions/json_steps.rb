# frozen_string_literal: true
require "json"

Then('the response should be a valid JSON:API resource document for type {string}') do |type|
  body = @last_response.fetch(:body)
  raise "response body was empty" if body.nil?

  # Top-level members: jsonapi is optional; data is required for resource document
  data = body.fetch("data")

  raise "data must be an object" unless data.is_a?(Hash)
  raise "type mismatch: #{data["type"].inspect}" unless data.fetch("type") == type

  # JSON:API requires id and type for resource objects
  data.fetch("id")
  data.fetch("attributes") # attributes required for this API contract
end

Then("the response should be a valid JSON:API error document") do
  body = @last_response.fetch(:body)
  raise "response body was empty" if body.nil?

  errors = body.fetch("errors")
  raise "errors must be an array" unless errors.is_a?(Array)
  raise "errors must not be empty" if errors.empty?
  raise "each error must be an object" unless errors.all? { |e| e.is_a?(Hash) }
end

Then('the JSON:API error should have status {string}') do |status|
  body = @last_response.fetch(:body)
  errors = body.fetch("errors")
  first = errors.first
  raise "missing error.status" unless first.key?("status")
  raise "expected status #{status}, got #{first["status"]}" unless first["status"].to_s == status
end

Then("the JSON:API document should include user attributes:") do |table|
  expected = table.rows_hash.transform_keys(&:to_s)
  body = @last_response.fetch(:body)

  attrs = body.fetch("data").fetch("attributes")
  raise "attributes must be an object" unless attrs.is_a?(Hash)

  expected.each do |k, v|
    raise "missing attribute #{k}" unless attrs.key?(k)
    actual = attrs[k]
    raise "expected #{k}=#{v.inspect}, got #{actual.inspect}" unless actual.to_s == v.to_s
  end
end
