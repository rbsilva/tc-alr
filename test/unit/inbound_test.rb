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

require 'test_helper'

class InboundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
