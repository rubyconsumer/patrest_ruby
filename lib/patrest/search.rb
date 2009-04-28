module PatRest
  class Search
    FACETS = %w(title author callnum keyword subject gvtdocnum stdnum titlekey controlnum barcode record bibnum itemnum)
    include HTTParty
    format :xml
    
    attr_accessor :type, :query, :per_page, :current_page, :results
    
    def initialize(type, query, options = {:per_page => 10, :page => 1})
      raise InvalidSearchType unless Search::FACETS.include?(type.to_s)
      self.type     = type
      self.query    = query
      self.per_page = options[:per_page]
      self.current_page = options[:page]
    end
    
    def escaped_query
      URI.escape(self.query)
    end
    
    def execute
      results = Search.get("/search/#{type}/#{escaped_query}/#{per_page}/#{current_page}")
      @results  = results['SearchResult']['Records']['Record'].collect {|attrs| PatRest::Record.new(attrs)}
      self
    end
    
    def next
      self.current_page += 1
      self.execute
    end
    
    def previous
      self.current_page -= 1
      self.current_page = 0 if self.current_page < 0 # cannot go into negative search results
      self.execute
    end
    
    def results
      @results || []
    end
    
    def method_missing(method, *args)
      unless self.results.respond_to?(method)
        message = "undefined method `#{method.to_s}' for \"#{@self}\":#{@self.class.to_s}"
        raise NoMethodError, message
      end

      if block_given?
        self.results.send(method, *args)  { |*block_args| yield(*block_args) }
      else
        self.results.send(method, *args)
      end
    end
  end
end