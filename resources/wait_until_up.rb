#
# Cookbook Name:: nexus
# Resource:: wait_until_up
#

actions :wait

def initialize(name, run_context=nil)
  super
  @action = :wait
end