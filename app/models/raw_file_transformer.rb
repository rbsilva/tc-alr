class RawFileTransformer < ActiveRecord::Base
  def self.run
    @raw_files = RawFile.where("status = 'SENT'")

    @raw_files.each do |raw_file|
      file = "tmp/#{raw_file.filename}"
      tempfile = File.new(file,'wb')
      tempfile << ActiveRecord::Base.connection.unescape_bytea(raw_file.file)
      tempfile.close

      is_valid = true

      inbound = Excel.new(file) rescue is_valid = false

      if !is_valid then
        is_valid = true
        inbound = Excelx.new(file) rescue is_valid = false
      end

      if !is_valid then
        is_valid = true
        inbound = Openoffice.new(file) rescue is_valid = false
      end

      if !is_valid then raise I18.t(:fatal_error) end

      content = inbound.to_xml()

      if inbound.is_a? Excel then
        inbound.get_workbook.get_io.close
      end

      Inbound.new(:raw_file_id => raw_file.id, :file => ActiveRecord::Base.connection.escape_bytea(content)).save

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
