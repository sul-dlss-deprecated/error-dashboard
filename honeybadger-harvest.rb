#!/usr/bin/env ruby

# Provide your honeybadger access token as the first argument

@token = ARGV[0]

require 'json'
require 'net/http'
require 'active_support'
require 'active_support/core_ext/hash'

def issues_for_project(id)
  json = api("https://app.honeybadger.io/v2/projects/#{id}/faults")
  json['results'].map do |res|
    res.slice('notices_count', 'klass', 'message', 'url')
  end
end

def project_list
  json = api('https://app.honeybadger.io/v2/projects')
  json['results'].map do |res|
    res.slice('id', 'name')
  end
end

def api(url)
  uri = URI(url)
  req = Net::HTTP::Get.new(uri)
  req.basic_auth @token, nil

  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(req)
  end

  json = JSON.parse(res.body)
end

def all_issues
  project_list.each_with_object([]) do |project, accum|
    puts "loading #{project['name']}(#{project['id']})"
    accum << issues_for_project(project['id']).map do |issue|
      issue.merge('project_name' => project['name'])
    end
  end.flatten.sort { |a, b| a['notices_count'].to_i <=> b['notices_count'].to_i }
end


File.open('top-errors.json', 'w') do |f|
  f.puts all_issues
end
