# frozen_string_literal: true

require 'json'
require 'net/http'
require 'active_support'
require 'active_support/core_ext/hash'
# A client for the honeybadger api
class Client
  ROOT = 'https://app.honeybadger.io/v2'
  def initialize(url, token)
    @uri = URI(ROOT + url)
    @token = token
  end

  def results
    json = JSON.parse(request.body)
    case request.code
    when "200"
      json['results'].map { |res| yield res }
    else
      $stderr.puts "Unexpected response code: #{request.code}, #{json['errors']}"
      []
    end
  end

  private

  attr_reader :uri

  def request
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @token, nil
    ssl = uri.scheme == 'https'
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: ssl) do |http|
      http.request(req)
    end
  end
end
