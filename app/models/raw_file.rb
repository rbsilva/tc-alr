# encoding: utf-8
class RawFile < ActiveRecord::Base
  attr_accessible :path, :tags

  validates :path,  :presence => true
  validates :tags, :presence => true,
                    :length => { :minimum => 3 },
                    :format => { :with => /^[A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]+([,][A-z0-9_\-ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž]*)*$/ }

end
