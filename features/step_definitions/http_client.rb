# features/support/http_client.rb
require "net/http"
require "json"
require "uri"

class HttpClient
  def initialize(base_url:)
    @base = URI(base_url)
  end

  def post_json(path, payload)
    uri = @base + path
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req.body = JSON.generate(payload)
    perform(uri, req)
  end

  def get(path)
    uri = @base + path
    req = Net::HTTP::Get.new(uri)
    perform(uri, req)
  end

  private

  def perform(uri, req)
    res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
    raw = res.body.to_s
    parsed = raw.empty? ? nil : JSON.parse(raw)
    { status: res.code.to_i, body: parsed, raw_body: raw }
  end
end
