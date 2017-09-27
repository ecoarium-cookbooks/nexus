
default[:nexus][:version]   = nil
default[:nexus][:url]       = nil
default[:nexus][:checksum]  = nil

default[:nexus][:app]       = 'nexus'
default[:nexus][:user]      = 'nexus'
default[:nexus][:group]     = 'nexus'
default[:nexus][:binaries]  = ['bin/nexus']

default[:nexus][:home]              = "/var/lib/#{node[:nexus][:user]}"
default[:nexus][:plugin_repo_path]  = "#{node[:nexus][:home]}/plugin-repository"
default[:nexus][:conf_dir]          = "/usr/local/#{node[:nexus][:app]}/conf"

default[:nexus][:port] = '8081'
default[:nexus][:host] = '0.0.0.0'
default[:nexus][:path] = '/'

default[:java][:jdk_version] = '7'
default[:java][:java_home] = '/usr/lib/jvm/java'
default[:java][:openjdk_packages] = [
  "java-1.#{node[:java][:jdk_version]}.0-openjdk", 
  "java-1.#{node[:java][:jdk_version]}.0-openjdk-devel"
]