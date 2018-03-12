# Produces a report of faults
class FaultReport
  # @param projects_by_group [Hash<String,Array<Project>>]
  def initialize(projects_by_group)
    @projects_by_group = projects_by_group
  end

  def to_json
    faults.to_json
  end

  private

  def faults
    @projects_by_group.each_with_object({}) do |(k, v), result|
      result[k] = top_issues(v)
    end
  end

  def all_issues(project_list)
    project_list.map do |project|
      puts "loading faults #{project.name}(#{project.id})"
      project.issues
    end
  end

  def top_issues(project_list)
    all_issues(project_list)
      .flatten
      .sort_by(&:notices_count)
      .last(20)
      .reverse
  end
end
