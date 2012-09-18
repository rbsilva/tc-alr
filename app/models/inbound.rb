# encoding: utf-8
class Inbound < ActiveRecord::Base
  belongs_to :raw_file
  attr_accessible :raw_file_id, :file

  validates :file, :presence => true
end