require 'project'
require 'deploy_report'
require 'fault_report'

# Writes the two reports for faults and deploys
class ReportWriter
  ACCESS = %w[arclight-demo
              bassi_veratti
              colligo
              content_search
              course_reserves
              demo.projectblacklight.org
              discovery-dispatcher
              dlme
              earthworks
              exhibits
              frda
              library_hours_rails
              mirador_sul
              revs
              revs-indexer-service
              rwj_reporting
              sul-bento-app
              sul-directory
              sul-embed
              sul-requests
              sw-indexer
              portfolios
              purl-fetcher
              SearchWorks
              Stacks
              PURL]
  INFRA = %w[argo
             assembly
             common-accessioning
             dpn-server
             dor-fetcher-service
             dor_indexing_app
             dor-services-app
             dor-scripts
             dor-utils
             editstore-updater
             etd-robots
             gis-robot-suite
             goobi-robot
             hydra_etd
             hydrus
             item-release
             modsulator-app
             preservation_catalog
             pre-assembly
             robot-master
             sdr-preservation-core
             sdr-services-app
             sul_pub
             taco
             was-thumbnail-service
             was-registrar
             was_robot_suite
             workflow-archiver-job
             DLSS-Wowza]
  IGNORE = %w[Nurax
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
