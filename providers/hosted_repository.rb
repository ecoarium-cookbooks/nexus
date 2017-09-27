#
# Cookbook Name:: nexus
# Provider:: hosted_repository
#

def nexus
  return @nexus unless @nexus.nil?
  @nexus = Chef::Nexus.new(new_resource.url, new_resource.username, new_resource.password, new_resource.repository)
end

action :create do
  require 'nexus_cli'

  repository = new_resource.repository
  policy = new_resource.policy
  repo_provider = new_resource.repo_provider

  unless repository_exists?(repository)
    Chef::Log.debug "creating nexus repository #{repository}"

    nexus.connection.create_repository(repository, false, nil, nil, policy, repo_provider)
    
    if new_resource.publisher
      nexus.connection.enable_artifact_publish(@parsed_id)
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "nexus repository #{repository} exists, no need to create it"

    new_resource.updated_by_last_action(false)
  end
end

def repository_exists?(name)
  begin
    nexus.connection.get_repository_info(name)
    true
  rescue NexusCli::RepositoryNotFoundException => e
    return false
  end
end