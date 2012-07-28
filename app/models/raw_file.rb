class RawFile < ActiveRecord::Base
  attr_accessible :path, :tags

  validates :path,  :presence => true
  validates :tags, :presence => true,
                    :length => { :minimum => 3 },
                    :format => { :with => /(([0-9a-zA-Z][0-9a-zA-Z_]*)([,][0-9a-zA-Z][0-9a-zA-Z_]*)*)/, :message =>
                    "The tags must be separated by comma (,)" }

end
