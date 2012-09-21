# encoding: utf-8
# == Schema Information
#
# Table name: inbounds
#
#  id          :integer          not null, primary key
#  file        :binary
#  raw_file_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Inbound < ActiveRecord::Base
  belongs_to :raw_file
  attr_accessible :raw_file_id, :file

  validates :file, :presence => true
end
