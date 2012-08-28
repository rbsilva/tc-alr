Excel.class_eval do
  def get_workbook
    @workbook
  end
end

Spreadsheet::Excel::Workbook.class_eval do
  def get_io
    @io
  end
end

class RawFileTransformer < ActiveRecord::Base
  def self.transform
    begin
      upload_dir = APP_CONFIG['upload_dir']
	  processed_dir = APP_CONFIG['processed_dir']
	  inbound_dir = APP_CONFIG['inbound_dir']
      if !Dir.exists? processed_dir then
        FileUtils.makedirs processed_dir
      end
	  if !Dir.exists? inbound_dir then
        FileUtils.makedirs inbound_dir
      end
	  
	  @raw_files = RawFile.where("status = 'SENT'")
	  @raw_files.each do |raw_file| 
		begin
			filename = raw_file.path
			file = File.join(upload_dir, filename)
			processed_file = File.join(processed_dir, filename)
			filename_yml = filename + '.yml'
			inbound_file = File.join(inbound_dir, filename_yml)
		  
			case File.extname(file)
			  when '.xls'
				inbound = Excel.new(file)
			  when '.csv'
				inbound = CSV.new(file)
			  else
			end
		  
		   
		  content = inbound.to_yaml

		  if inbound.is_a? Excel then
			inbound.get_workbook.get_io.close
		  end
		  
		  File.open(inbound_file, 'w') {|f| f.write(content) }
		  raw_file.status = 'PROCESSED'
		  raw_file.save
		  FileUtils.mv file, processed_file
		  ActiveRecord::Base.connection.close
		  true
		rescue Exception => e
		  logger.fatal e
		end
	  end
    rescue Exception => e
	  logger.fatal e
    end
  end
end

class CSV
	def initialize(input) 
		require 'csv'
		require 'yaml'

		doc = CSV.read(input)
		fields = doc.shift
		records = Hash.new
		doc.each_with_index do |row, i|
		  record = Hash.new
		  fields.each_with_index do |field, j|
			record[field] = row[j]
		  end
		  records["record_#{i}"] = record
		end
		@records = records
	end
	
	def to_yaml
		@records.to_yaml
	end
end