require 'json'
require 'yaml'
require 'webrockitapi_helper'
require 'config_helper'

#TODO: need to return the proper json sucess/error object on these
# this helper needs to call the typelist and verifies the user provided a proper type

module CheckHelper
  @config = ConfigHelper.hash()
  def self.import(typename)
    basedir = @config['sensu']['basedir']
    if typename == 'all'
      #fetch all types from webrockit
      types = JSON.parse(WebrockitapiHelper.fetchTypes())['data']

      #query check types
      types.each do |type|
        puts "##### #{type} #####"

        #clear out types dir and create if not exist
        directory = "#{basedir}/#{type}"
        if Dir.exists?(directory)
          puts "** Clearing objects for #{type}"
          files = Dir.entries(directory)
          files.each do |file|
            if Regexp.new("json") =~ file
              puts "\tremoving #{file}"
            end
          end
        else
          puts "Creating directory for #{type}"
          Dir.mkdir(directory)
        end

        #fetch checks and write the files out
        checks = JSON.parse(WebrockitapiHelper.fetchCheckList(type))['data']
        checks.each do |check|
          name = check.split('::')[1]
          filename = "#{basedir}/#{type}/#{name}.json"
          checkjs = JSON.parse(WebrockitapiHelper.fetchCheck(type,name))['data'].to_json
          puts "\tFile: #{filename}"
          #puts "\t\tContents: #{checkjs}"
          File.open("#{filename}", "w") do |f|
              f.write checkjs
          end
        end
      end

    else
      type = typename
      puts "##### #{type} #####"

      #clear out types dir and create if not exist
      directory = "#{basedir}/#{type}"
      if Dir.exists?(directory)
        puts "** Clearing objects for #{type}"
        files = Dir.entries(directory)
        files.each do |file|
          if Regexp.new("json") =~ file
            puts "\tremoving #{file}"
          end
        end
      else
        puts "Creating directory for #{type}"
        Dir.mkdir(directory)
      end

      #fetch checks and write the files out
      checks = JSON.parse(WebrockitapiHelper.fetchCheckList(type))['data']
      checks.each do |check|
        name = check.split('::')[1]
        filename = "#{basedir}/#{type}/#{name}.json"
        checkjs = JSON.parse(WebrockitapiHelper.fetchCheck(type,name))['data'].to_json
        puts "\tFile: #{filename}"
        File.open("#{filename}", "w") do |f|
            f.write checkjs
        end
      end
    end
  end
end