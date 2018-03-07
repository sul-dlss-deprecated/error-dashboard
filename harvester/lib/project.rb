require 'client'
require 'issue'

# Represents a project in honeybadger
class Project
  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.project_list(token)
    client = Client.new('https://app.honeybadger.io/v2/projects', token)
    client.results do |res|
      Project.new(res.slice('id', 'name').symbolize_keys)
    end
  end

  attr_reader :id, :name

  # gets all the issues for the project except those that are resolved
  def issues(token)
    all_issues(token).select(&:open?)
  end

  private

  def all_issues(token)
    client = Client.new(faults_url, token)
    client.results do |res|
      Issue.new res
        .slice('notices_count', 'klass', 'message', 'url', 'resolved')
        .merge(project_name: name)
        .symbolize_keys
    end
  end

  def faults_url
    "https://app.honeybadger.io/v2/projects/#{id}/faults"
  end
end
