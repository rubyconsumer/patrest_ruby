require File.join(File.dirname(__FILE__), '..', 'lib', 'patrest')
require 'spec'
include PatRest

BASE_URI = 'http://www.aadl.org/rest'

PatRest::Options.base_uri("#{BASE_URI}/")


def file_fixture(filename)
  open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}")).read
end

def mock_http(method, request_uri, filename)
  format = filename.split('.').last.intern
  data = file_fixture(filename)

  response = Net::HTTPOK.new("1.1", 200, "Content for you")
  response.stub!(:body).and_return(data)
  
  case method
  when :get
    http_class = Net::HTTP::Get
  end
  
  http_request = HTTParty::Request.new(http_class, request_uri, :base_uri => BASE_URI, :format => format)
  http_request.stub!(:perform_actual_request).and_return(response)

  HTTParty::Request.should_receive(:new).with(http_class, request_uri, hash_including(:base_uri => BASE_URI)).and_return(http_request)
  [http_request, response]
end