
class Chef
  class Nexus

    attr_reader :connection

    def initialize(url, username, password, repository='releases')
      require 'nexus_cli'

      connection_key = [url, username, password, repository].join('-.-')

      @connection = self.class.connections[connection_key] unless self.class.connections[connection_key].nil?

      @connection = NexusCli::RemoteFactory.create(
        {
          'url' => url,
          'username' => username,
          'password' => password,
          'repository' => repository
        }
      )

      self.class.connections[connection_key] = @connection
    end

    class << self

      @@connections = {}
      def connections
        @@connections
      end
      
    end
  end
end