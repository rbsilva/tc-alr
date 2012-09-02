# encoding: UTF-8
class Admin::InboundController < ApplicationController
  def list
    require 'csv'
    require 'yaml'

    YAML::ENGINE.yamler='psych'

    @inbounds = []

    inbound_dir = APP_CONFIG['inbound_dir']

    @raw_files = RawFile.where("status = 'PROCESSED'")

    @raw_files.each do |raw_file|
      begin
        path = raw_file.path + '.yml'
        file = File.join(inbound_dir, path)

        @inbounds << [YAML::load(IO.read(file)), raw_file]
      rescue SyntaxError, StandardError
        @inbounds << [IO.read(file), raw_file, $!] rescue @inbounds << ['',raw_file, $!]
      end
    end
    begin
      respond_to do |format|
        format.html
      end
    rescue
      logger.fatal $!
    end
  end
end
