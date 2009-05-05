module PatRest
  class Patron
    include HTTParty
    format :xml
    base_uri('http://www.aadl.org/rest/')
    
    attr_reader :token
    
    def initialize(token)
      @token = token
    end
    
    def items
      @items ||= parse_single_or_many_records(Patron.get("/checkouts/#{token}")['Checkouts'])
    end
    
    def holds
      @holds ||= parse_single_or_many_records(Patron.get("/holds/#{token}")['Holds'])
    end
    
    private
      def parse_single_or_many_records(query_result)
        unless query_result['Record'].is_a? Array
           [PatRest::Record.new(query_result['Record'])]
        else
          query_result['Record'].collect {|attrs| PatRest::Record.new(attrs) }
        end
      end
  end
end