# Represents an open issue on Honeybadger
class Issue
  def initialize(args = {})
    @args = args
  end

  def self.for(project:, token:)
    client = Client.new(faults_path(project.id), token)
    client.results do |res|
      Issue.new res
        .slice('notices_count', 'klass', 'message', 'url', 'resolved')
        .merge(project_name: project.name)
        .symbolize_keys
    end
  end

  delegate :[], to: :@args

  def open?
    !self[:resolved]
  end

  def notices_count
    self[:notices_count].to_i
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def as_json(*)
    @args.merge(notices_count: notices_count)
  end

  def self.faults_path(project_id)
    "/projects/#{project_id}/faults"
  end
  private_class_method :faults_path
end
