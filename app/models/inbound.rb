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
  require 'xmlsimple'

  belongs_to :raw_file
  attr_accessible :raw_file_id, :file

  validates :file, :presence => true

  def xml_file
    XmlSimple.xml_in(ActiveRecord::Base.connection.unescape_bytea(file))
  rescue SyntaxError, StandardError
    xml_error = %Q(
      <spreadsheet>
        <sheet name="ERROR">
          <cell row="1" column="1" type="string">#{I18n.t(:raw_file)}</cell>
          <cell row="1" column="2" type="string">#{I18n.t(:error)}</cell>
          <cell row="2" column="1" type="string">#{file}</cell>
          <cell row="2" column="2" type="string">#{$!}</cell>
        </sheet>
      </spreadsheet>
    )

    XmlSimple.xml_in(xml_error)
  end
end
