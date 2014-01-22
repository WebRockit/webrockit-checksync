require 'sinatra'
require 'json'

#load in our helpers
require 'schema_helper'
require 'check_helper'
require 'sensu_helper'
require 'config_helper'


module WebrockitCheckSync
  class Api < Sinatra::Base

    @config = ConfigHelper.hash()
    #setup some basic auth
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      username == @config['application']['basic_auth']['user']
      password == @config['application']['basic_auth']['pass']
    end

    get '/' do
      data = SchemaHelper.showInitial(request)
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    get '/schemas' do 
      data = SchemaHelper.showSchemas(request)
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    get '/v1/importByType' do
      error = 'none'
      required_params = ['type']
      required_params.each do |param|
        if params[param].nil?
          error = "missing a required parameter -> #{param}"
        end
      end  

      if error == 'none'
        data = CheckHelper.import(params['type'])
        if Regexp.new("json") =~ request.accept.to_s
          content_type :json
          data
        else
          erb :html_ui, :locals => {:data => data}
        end
      else 
        status 500
        {'status' => 'error', 'message' => error}.to_json
      end
    end

    get '/v1/importAll' do
      data = CheckHelper.import('all')
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

    get '/v1/loadChecks' do
      data = SensuHelper.loadChecks
      if Regexp.new("json") =~ request.accept.to_s
        content_type :json
        data
      else
        erb :html_ui, :locals => {:data => data}
      end
    end

  end
end
