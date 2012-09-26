# encoding: UTF-8
class Admin::InboundController < BaseController

  def list
    require 'csv'
    require 'xmlsimple'

    @inbounds = []

    @raw_files = RawFile.where("status = 'PROCESSED'")

    @raw_files.each do |raw_file|
      begin
        file = Inbound.where("raw_file_id = #{raw_file.id}").first.file
        @inbounds << [XmlSimple.xml_in(ActiveRecord::Base.connection.unescape_bytea(file)), raw_file]
      rescue SyntaxError, StandardError
        @inbounds << [file, raw_file, $!] rescue @inbounds << ['',raw_file, $!]
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
