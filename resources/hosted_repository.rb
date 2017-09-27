#
# Cookbook Name:: nexus
# Resource:: hosted_repository
#

actions :create
default_action :create

attribute :username,      kind_of: String
attribute :password,      kind_of: String
attribute :url,           kind_of: String
attribute :repository,    kind_of: String, name_attribute: true
attribute :publisher,     kind_of: [TrueClass, FalseClass], default: nil
attribute :policy,        kind_of: String, default: nil
attribute :repo_provider, kind_of: String, default: nil

def initialize(name, run_context=nil)
  super

  @url = "http://localhost:#{node[:nexus][:port]}"
end