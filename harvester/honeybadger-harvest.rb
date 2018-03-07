#!/usr/bin/env ruby

# Provide your honeybadger access token as the first argument

@token = ARGV[0]
$LOAD_PATH.unshift('lib')
require 'project'
require 'byebug'

def all_issues
  Project.project_list(@token).each_with_object([]) do |project, accum|
    puts "loading #{project.name}(#{project.id})"
    accum << project.issues(@token)
  end
end

def top_issues
  all_issues
    .flatten
    .sort_by(&:notices_count)
    .take(20)
end

File.open('../static/top-errors.json', 'w') do |f|
  f.puts top_issues.to_json
end
