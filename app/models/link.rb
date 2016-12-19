require 'uri'

class Link < ActiveRecord::Base
  validate :url_must_be_valid

  def url_must_be_valid
    unless url =~ /\A#{URI::regexp}\z/
      errors.add(:url, 'Must be a valid URL')
    end
  end
end
