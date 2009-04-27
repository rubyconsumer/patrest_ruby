$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'httparty'
require 'uri'
require 'patrest/patron'
require 'patrest/record'
require 'patrest/search'

module PatRest
  class Options
    def self.base_uri(uri)
      PatRest::Patron.base_uri(uri)
      PatRest::Record.base_uri(uri + 'record')
      PatRest::Search.base_uri(uri + 'search')
    end
  end
  
  class RecordNotFound < StandardError
  end
  
  class InvalidSearchType < StandardError
  end
  
  class InvalidPatronToken < StandardError
  end
end