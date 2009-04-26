$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'httparty'
require 'uri'
require 'patrest/patron'
require 'patrest/record'
require 'patrest/search'

module PatRest
  OPTIONS = {'BASE_URI' => ''}
  class RecordNotFound < StandardError
  end
  
  class InvalidSearchType < StandardError
  end
  
  class InvalidPatronToken < StandardError
  end
end