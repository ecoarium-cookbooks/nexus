#
# Cookbook Name:: nexus
# Provider:: user
#


action :change_password do
  require 'nexus_cli'

  url           = new_resource.url
  username      = new_resource.username
  password      = new_resource.password
  old_password  = new_resource.old_password
  repository    = new_resource.repository

  begin
    nexus = Chef::Nexus.new(url, username, old_password, repository)

    Chef::Log.debug "changing password for nexus users: #{username}"

    nexus.connection.change_password(userId: username, oldPassword: old_password, newPassword: password)
    
    new_resource.updated_by_last_action(true)  
  rescue Exception => e

    Chef::Log.debug "not changing password for nexus users: #{username}

#{e.message}

"
    new_resource.updated_by_last_action(false)
  end
end
