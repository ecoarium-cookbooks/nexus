#
# Cookbook Name:: nexus
# Provider:: wait_until_up
#

action :wait do

  ruby_block "block_until_nexus_is_operational" do
    block do
      max_attempts = 80

      listening = false
      1.upto(max_attempts).each{ |attempt|
        Chef::Log.info("Waiting for nexus to be available(watching netstat for listening on port #{node[:nexus][:port]}): attempt #{attempt} of #{max_attempts}")

        if system "netstat -tupln | awk '{print $4 \" \" $6 \" \" $7}' | egrep '#{node[:nexus][:port]}\s+LISTEN\s+[[:digit:]]+/java'"
          listening =true
          break
        end

        sleep 5
      }

      unless listening
        log_file_path = "/usr/local/#{node[:nexus][:app]}/logs/wrapper.log"

        log_tail = `tail -n 20 #{log_file_path}`

        Chef::Application.fatal!("Nexus never started. The log file may have useful information(#{log_file_path}):
#################### BEGIN TAIL LOG ####################

#{log_tail}

##################### END TAIL LOG #####################
")
      end

      responsive = false
      url = URI.parse("http://localhost:#{node[:nexus][:port]}/index.html")
      1.upto(max_attempts).each{ |attempt|
        Chef::Log.info("Waiting for nexus to be available at #{url}: attempt #{attempt} of #{max_attempts}")

        repsonse = Chef::REST::RESTRequest.new(:GET, url, nil).call rescue nil

        if repsonse.kind_of?(Net::HTTPSuccess) or repsonse.kind_of?(Net::HTTPNotFound)
          responsive =true
          break
        end

        Chef::Log.debug "Nexus not responding at #{url}: #{repsonse.inspect}"
        sleep 1
      }

      
      unless responsive
        log_file_path = "/usr/local/#{node[:nexus][:app]}/logs/wrapper.log"

        log_tail = `tail -n 20 #{log_file_path}`

        Chef::Application.fatal!("Nexus is not responsive at #{url}. The log file may have useful information(#{log_file_path}):
#################### BEGIN TAIL LOG ####################

#{log_tail}

##################### END TAIL LOG #####################
")
      end
    end
  end

  new_resource.updated_by_last_action(true)
end
