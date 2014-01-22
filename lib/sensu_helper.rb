require 'json'

module SensuHelper
  def self.loadChecks()
    result = `/etc/init.d/sensu-server restart && /etc/init.d/sensu-api restart`
    return result
  end
end