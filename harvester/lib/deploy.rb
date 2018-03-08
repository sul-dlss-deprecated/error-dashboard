class Deploy
  def self.last_for(project:, token:, environment: 'prod')
    cli = Client.new("/projects/#{project.id}/deploys?environment=#{environment}&limit=1", token)
    row = cli.results { |res| res.slice('created_at').symbolize_keys }.first
    row = {} if row.nil?
    row.merge(project_name: project.name)
  end
end
