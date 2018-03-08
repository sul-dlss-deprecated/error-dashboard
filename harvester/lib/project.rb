require 'client'
require 'issue'
require 'deploy'

# Represents a project in honeybadger
class Project
  def initialize(id:, name:, token:)
    @id = id
    @name = name
    @token = token
  end

  def self.project_list(token)
    client = Client.new('/projects', token)
    client.results do |res|
      Project.new(res.slice('id', 'name').symbolize_keys.merge(token: token))
    end
  end

  attr_reader :id, :name

  # gets all the issues for the project except those that are resolved
  def issues
    Issue.for(project: self, token: @token).select(&:open?)
  end

  # gets all the issues for the project except those that are resolved
  def last_deploy
    Deploy.last_for(project: self, token: @token)
  end
end
