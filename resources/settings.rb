#
# Cookbook Name:: nexus
# Resource:: settings
#

actions :update
default_action :update

attribute :username,      kind_of: String
attribute :password,      kind_of: String
attribute :url,           kind_of: String
attribute :repository,    kind_of: String
attribute :settings,      kind_of: Hash

def initialize(name, run_context=nil)
  super

  @url = "http://localhost:#{node[:nexus][:port]}"
end