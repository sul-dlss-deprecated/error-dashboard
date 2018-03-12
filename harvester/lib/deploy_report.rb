# Produces a report of deployments
class DeployReport
  # @param projects_by_group [Hash<String,Array<Project>>]
  def initialize(projects_by_group)
    @projects_by_group = projects_by_group
  end

  def to_json
    deploys.to_json
  end

  private

  def deploys
    @projects_by_group.each_with_object({}) do |(k, v), result|
      result[k] = fetch_deploys(v)
    end
  end

  # @param project_list[Array<Project>]
  def fetch_deploys(project_list)
    project_list.map do |project|
      puts "loading deploys #{project.name}(#{project.id})"
      project.last_deploy
    end
  end
end
