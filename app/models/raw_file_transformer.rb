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
		  puts raw_file.path
		  inbound_file = File.join(inbound_dir, filename_yml)
		  inbound = Excel.new(file)
		  inbound = inbound.to_yaml
		  File.open(inbound_file, 'w') {|f| f.write(inbound) }
		  raw_file.status = 'PROCESSED'
		  raw_file.save
		  FileUtils.mv file, processed_file
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
