class RawFileTransformer < ActiveRecord::Base
  def self.transform
    require 'csv'
    require 'yaml'

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
      filename = raw_file.path
      file = File.join(upload_dir, filename)
      processed_file = File.join(processed_dir, filename)
      filename_yml = filename + '.yml'
      inbound_file = File.join(inbound_dir, filename_yml)
      is_valid = true

      inbound = Excel.new(file) rescue is_valid = false

      if !is_valid then
        inbound = Excelx.new(file) rescue logger.fatal($!)
        is_valid = true
      end

      if !is_valid then
        inbound = CSV.read(file) rescue logger.fatal($!)
        is_valid = true
      end

      if !is_valid then raise 'Fatal Error' end

      content = inbound.to_yaml(:encoding => :utf8)

      if inbound.is_a? Excel then
        inbound.get_workbook.get_io.close
      end

      File.open(inbound_file, 'w') {|f| f.write(content) }
      raw_file.status = 'PROCESSED'
      raw_file.save
      FileUtils.mv file, processed_file
      ActiveRecord::Base.connection.close
      true
    end
  rescue Exception => e
    logger.fatal e
  end
end
