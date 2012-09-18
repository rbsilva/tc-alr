# encoding: utf-8
class RawFile < ActiveRecord::Base
  belongs_to :user
  attr_writer :attach_a_file
  attr_accessible :user_id, :file, :filename, :content_type, :template, :status

  validates :file, :presence => true
  validates :template, :presence => true,
            :length => {:minimum => 3},
            :format => {:with => /^[A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]+([,][A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]*)*$/}
            
  def uploaded_file=(incoming_file)
      self.filename = incoming_file.original_filename
      self.content_type = incoming_file.content_type
      self.file = incoming_file.read
  end

  def filename=(new_filename)
      write_attribute("filename", sanitize_filename(new_filename))
  end

  private

  def sanitize_filename(filename)
      #get only the filename, not the whole path (from IE)
      just_filename = File.basename(filename)
      #replace all non-alphanumeric, underscore or periods with underscores
      just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
