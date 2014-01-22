require 'json'
require 'yaml'
require 'httparty'
require 'config_helper'

module WebrockitapiHelper
  @config = ConfigHelper.hash()
  def self.fetchTypes()
    apiconf = @config['webrockit']
    host = apiconf['host']
    port = apiconf['port']
    
    url = "http://#{host}:#{port}/v1/listTypes"

    requesturi = URI.escape(url)
    auth = {:username => apiconf['user'], :password => apiconf['pass']}
    response = HTTParty.get(requesturi,:basic_auth => auth, :headers => {"Accept" => 'application/json'})
    if response.code == 200
      data = response.body
    else
      data = "FAIL"
    end
    return data
  end

  def self.fetchCheckList(type)
    apiconf = @config['webrockit']
    host = apiconf['host']
    port = apiconf['port']
    
    baseurl = "http://#{host}:#{port}/v1/listChecks?"
    opts = "type=#{type}"

    url = "#{baseurl}#{opts}"
    requesturi = URI.escape(url)
    auth = {:username => apiconf['user'], :password => apiconf['pass']}
    response = HTTParty.get(requesturi,:basic_auth => auth, :headers => {"Accept" => 'application/json'})
    if response.code == 200
      data = response.body
    else
      data = "FAIL"
    end
    return data
  end

  def self.fetchCheck(type,name)
    apiconf = @config['webrockit']
    host = apiconf['host']
    port = apiconf['port']
    
    baseurl = "http://#{host}:#{port}/v1/fetchCheck?"
    opts = "type=#{type}&name=#{name}"

    url = "#{baseurl}#{opts}"
    requesturi = URI.escape(url)
    auth = {:username => apiconf['user'], :password => apiconf['pass']}
    response = HTTParty.get(requesturi,:basic_auth => auth, :headers => {"Accept" => 'application/json'})
    if response.code == 200
      data = response.body
    else
      data = "FAIL"
    end
    return data
  end
end