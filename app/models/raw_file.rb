# encoding: utf-8
class RawFile < ActiveRecord::Base
  attr_writer :attach_a_file
  attr_accessible :path, :tags, :attach_a_file

  validates :path, :presence => true
  validates :tags, :presence => true,
            :length => {:minimum => 3},
            :format => {:with => /^[A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]+([,][A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]*)*$/}

end
