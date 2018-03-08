#!/usr/bin/env ruby

# Provide your honeybadger access token as the first argument

@token = ARGV[0]
$LOAD_PATH.unshift('lib')
require 'project'
require 'byebug'

def project_list
  @project_list ||= Project.project_list(@token)
end

def deploys(project_list)
  project_list.each_with_object([]) do |project, accum|
    puts "loading deploys #{project.name}(#{project.id})"
    accum << project.last_deploy
  end
end

def all_issues(project_list)
  project_list.each_with_object([]) do |project, accum|
    puts "loading faults #{project.name}(#{project.id})"
    accum << project.issues
  end
end

def top_issues(project_list)
  all_issues(project_list)
    .flatten
    .sort_by(&:notices_count)
    .take(20)
end


puts deploys(project_list)
# File.open('../static/top-errors.json', 'w') do |f|
#   #f.puts Project.new(name: 'Stacks', id: '49299').issues.to_json
#   f.puts Project.new(name: 'Stacks', id: '49299').last_deploy.to_json
#
#   #f.puts top_issues(project_list).to_json
# end
