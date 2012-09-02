class Admin::InboundController < ApplicationController
  def list
    require 'csv'
    require 'yaml'

    @inbounds = []

    inbound_dir = APP_CONFIG['inbound_dir']

    @raw_files = RawFile.where("status = 'PROCESSED'")

    @raw_files.each do |raw_file|
      begin
        path = raw_file.path + '.yml'
        file = File.join(inbound_dir, path)
        @inbounds << [YAML::load_file(file), raw_file]
      rescue
        @inbounds << [File.open(file).gets, raw_file, $!] rescue @inbounds << ['',raw_file, $!]
      end
    end

    respond_to do |format|
      format.html
    end
  end
end
