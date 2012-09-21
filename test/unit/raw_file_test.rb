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

require 'test_helper'

class RawFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
