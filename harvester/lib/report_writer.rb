require 'project'
require 'deploy_report'
require 'fault_report'

# Writes the two reports for faults and deploys
class ReportWriter
  ACCESS = %w[SearchWorks earthworks revs revs-indexer-service exhibits frda
              sul-embed discovery-dispatcher sw-indexer sul-bento-app colligo
              mirador_sul content_search course_reserves sul-requests
              library_hours_rails sul-directory bassi_veratti
              demo.projectblacklight.org portfolios dlme rwj_reporting
              arclight-demo]
  INFRA = %w[gis-robot-suite argo Stacks PURL dor-services-app dor_indexing_app
             hydrus purl-fetcher editstore-updater preservation_catalog assembly
             was-thumbnail-service sul_pub workflow-archiver-job hydra_etd
             dor-fetcher-service taco was-registrar dor-utils dor-scripts
             pre-assembly was_robot_suite common-accessioning etd-robots
             modsulator-app robot-master item-release goobi-robot
             sdr-preservation-core sdr-services-app dpn-server DLSS-Wowza]
  IGNORE = %w[HyBox
              Nurax
              dor-utils] # Ignoring dor-utils because it's a CLI

  def self.write(token:, path:)
    new(token: token, path: path).write
  end

  def initialize(token:, path:)
    @token = token
    @output_path = path
  end

  def write
    projects_by_group = project_list.group_by { |project| category_for(project) }
    write_deploy_report(projects_by_group)
    write_fault_report(projects_by_group)
  end

  def write_deploy_report(projects_by_group)
    File.open(File.join(@output_path, 'deploys.json'), 'w') do |f|
      f.puts DeployReport.new(projects_by_group).to_json
    end
  end

  def write_fault_report(projects_by_group)
    File.open(File.join(@output_path, 'top-errors.json'), 'w') do |f|
      f.puts FaultReport.new(projects_by_group).to_json
    end
  end

  def project_list
    @project_list ||= Project.project_list(@token).delete_if { |p| ignore?(p) }
  end

  def ignore?(project)
    IGNORE.include?(project.name)
  end

  def category_for(project)
    if ACCESS.include? project.name
      'access'
    elsif INFRA.include? project.name
      'infrastructure'
    else
      'unassigned'
    end
  end
end
