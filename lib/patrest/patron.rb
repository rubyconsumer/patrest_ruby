module PatRest
  class Patron
    include HTTParty
    format :xml
    base_uri 'http://www.aadl.org/rest/'
    
    attr_reader :token
    def initialize(token)
      @token = token
    end
    
    def items
      @items ||= Patron.get("/checkouts/#{token}")['Checkouts']['Record'].collect {|attrs| PatRest::Record.new(attrs)}
    end
    
    def holds
      @holds  ||= Patron.get("/holds/#{token}").collect {|attrs| PatRest::Record.new(attrs)}
    end
  end
end