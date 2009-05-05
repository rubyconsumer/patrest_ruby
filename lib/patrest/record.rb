module PatRest
  class Record
    include HTTParty
    format :xml
    base_uri('http://www.aadl.org/rest/')
    
    attr_accessor :attributes
    def self.find(record_number)
      attrs = get("/record/#{record_number}")
      raise PatRest::RecordNotFound if attrs['Record']['error']
      self.new(attrs['Record'])
    end
    
    def self.search(type, string, options = {:per_page => 10, :page => 1})
      
    end
    
    def initialize(attrs)
      self.attributes = attrs
    end
    
    def method_missing(method)
      method = method.to_s
      attributes.has_key?(method) ? attributes[method] : raise(NoMethodError)
    end
  end
end