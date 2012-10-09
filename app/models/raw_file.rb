# encoding: utf-8
# == Schema Information
#
# Table name: raw_files
#
#  id           :integer          not null, primary key
#  file         :binary
#  template     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  status       :string(255)
#  filename     :string(255)      default(""), not null
#  content_type :string(255)      default(""), not null
#

class RawFile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :file, :filename, :content_type, :template, :status, :header

  validates :header, :inclusion => { :in => ['COL','LIN'] }
  validates :file, :presence => true
  validates :template, :presence => true,
            :length => {:minimum => 3},
            :format => {:with => /^[A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]+([,][A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]*)*$/}
            
  def uploaded_file=(incoming_file)
      write_attribute(:filename, sanitize_filename(incoming_file.original_filename))
      write_attribute(:file, ActiveRecord::Base.connection.escape_bytea(incoming_file.read))
      write_attribute(:content_type, incoming_file.content_type)
  end

  private

  def sanitize_filename(filename)
      #get only the filename, not the whole path (from IE)
      just_filename = File.basename(filename)
      #replace all non-alphanumeric, underscore or periods with underscores
      just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
