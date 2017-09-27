#
# Cookbook Name:: nexus
# Resource:: user
#

actions :change_password
default_action :change_password

attribute :username,      kind_of: String, name_attribute: true
attribute :first_name,    kind_of: String
attribute :last_name,     kind_of: String
attribute :email,         kind_of: String
attribute :enabled,       kind_of: [TrueClass, FalseClass]
attribute :password,      kind_of: String
attribute :old_password,  kind_of: String
attribute :url,           kind_of: String
attribute :roles,         kind_of: Array, default: []
attribute :repository,    kind_of: String, default: 'releases'

def initialize(name, run_context=nil)
  super

  @url = "http://localhost:#{node[:nexus][:port]}"
end