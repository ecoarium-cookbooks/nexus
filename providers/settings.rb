#
# Cookbook Name:: nexus
# Provider:: settings
#

def nexus
  return @nexus unless @nexus.nil?
  @nexus = Chef::Nexus.new(new_resource.url, new_resource.username, new_resource.password, new_resource.repository)
end

action :update do
  require 'nexus_cli'
  require 'deep_merge'
  require 'json'

  current_settings = JSON.parse(nexus.connection.get_global_settings_json, symbolize_names: true)

  desired_settings = current_settings.deep_merge({
    data: new_resource.settings
  })

  nexus.connection.upload_global_settings(JSON.dump(desired_settings))
  
  new_resource.updated_by_last_action(true)
end