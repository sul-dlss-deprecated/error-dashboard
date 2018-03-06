#!/usr/bin/env ruby

# Provide your honeybadger access token as the first argument

@token = ARGV[0]

require 'byebug'
require 'json'
require 'net/http'
require 'active_support'
require 'active_support/core_ext/hash'

def issues_for_project(id)
  json = api("https://app.honeybadger.io/v2/projects/#{id}/faults?resolved=false")
  json['results'].map do |res|
    res.slice('notices_count', 'klass', 'message', 'url', 'resolved')
  end.select { |res| !res['resolved'] }
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
  end
end

def top_issues
  all_issues
    .flatten
    .sort { |a, b| b['notices_count'].to_i <=> a['notices_count'].to_i }
    .take(20)
end


File.open('static/top-errors.json', 'w') do |f|
  f.puts top_issues.to_json
end
