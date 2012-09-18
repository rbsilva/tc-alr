class RawFileTransformer < ActiveRecord::Base
  def self.transform
    require 'csv'
    require 'yaml'

    @raw_files = RawFile.where("status = 'SENT'")

    @raw_files.each do |raw_file|
      file = "tmp/#{raw_file.filename}"  
      tempfile = File.new(file,'wb')
      tempfile << raw_file.file
      tempfile.close
      
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

      content = inbound.to_yaml()

      if inbound.is_a? Excel then
        inbound.get_workbook.get_io.close
      end
      yaml_file = StringIO.new()
      yaml_file << content
      Inbound.new(:raw_file_id => raw_file.id, :file => yaml_file.read).save
      yaml_file.close
      raw_file.status = 'PROCESSED'
      raw_file.save
      File.delete(file)
      ActiveRecord::Base.connection.close
      true
    end
  rescue Exception => e
    logger.fatal e
  end
end
