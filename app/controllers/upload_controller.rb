class UploadController < ApplicationController

  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  def index
    @raw_file = RawFile.new
  end
  
  def save
    require 'fileutils'
    rawfile = params[:file_upload][:raw_file]
    if rawfile.nil? then
      @nil = true 
    else
      tempfile = rawfile.tempfile
      original_filename = params[:file_upload][:raw_file].original_filename
      file = File.join("app/raw_files", original_filename)
      FileUtils.cp tempfile.path, file
      
      path = file
      tags = params[:file_upload][:tags]
            
      @raw_file = RawFile.new(:path => path, :tags => tags)
      @raw_file.save
    end
    render 'index'
  end
end
