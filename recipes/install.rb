#
# Cookbook Name:: nexus
# Recipe:: install
#

include_recipe "ark"
include_recipe "java"

group node[:nexus][:group] do
  system true
end

user node[:nexus][:user] do
  gid node[:nexus][:group]
  shell "/bin/bash"
  home node[:nexus][:home]
  system true
end

directory node[:nexus][:home] do
  owner node[:nexus][:user]
  group node[:nexus][:group]
end

ark node[:nexus][:app] do
  url node[:nexus][:url]
  checksum node[:nexus][:checksum]
  version node[:nexus][:version]
  owner node[:nexus][:user]
  group node[:nexus][:group]
  has_binaries node[:nexus][:binaries]
  action :install
end

template "#{node[:nexus][:conf_dir]}/nexus.properties" do
  source "nexus.properties.erb"
  owner node[:nexus][:user]
  group node[:nexus][:group]
  notifies :restart, "service[#{node[:nexus][:app]}]"
end

template "/etc/init.d/#{node[:nexus][:app]}" do
  source "nexus.erb"
  mode "0775"
  notifies :restart, "service[#{node[:nexus][:app]}]"
end

directory node[:nexus][:plugin_repo_path] do
  owner node[:nexus][:user]
  group node[:nexus][:group]
end

service node[:nexus][:app] do
  supports :status => true, :start => true, :stop => true, :restart => true
  status_command "sudo service nexus status | grep -q 'is running'"
  action [:enable, :start]
end

nexus_wait_until_up 'nexus_install'

chef_gem "nexus_cli" do
  version "4.1.0"
end