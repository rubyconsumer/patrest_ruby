require File.dirname(__FILE__) + '/spec_helper'

describe Search do
  before do
    type  = 'author'
    query = 'hawking'
    per_page = 10
    page     = 1
    mock_http(:get, "/search/#{type}/#{query}/#{per_page}/#{page}", 'search_hawking.xml')
    @search = Search.new(type, query)
  end
  
  it "has no results until you execute" do
    @search.results.should be_empty
    @search.execute
    @search.results.should_not be_empty
  end
  
  it "has an array of Record items" do
    @search.execute
    @search.results.should be_kind_of(Array)
    @search.results[0].should be_kind_of(PatRest::Record)
  end
end

describe Search, 'navigation' do
  it 'can get the next n results'
  it 'can get the previous n reults'
  it 'can never go into negative results'
end

describe Search, 'array-like behavior' do
  before do
    type  = 'author'
    query = 'hawking'
    per_page = 10
    page     = 1
    mock_http(:get, "/search/#{type}/#{query}/#{per_page}/#{page}", 'search_hawking.xml')
    @search = Search.new(type, query).execute
  end
  
  it 'fowards array methods to results method' do
    @search.size.should eql(@search.results.size)
    @search.collect {|r| r.bibnum }.should eql(@search.results.collect {|r| r.bibnum})
  end
end

describe Search, 'with unknown search facet' do
  it "raises PatRest::InvalidSearch error" do
    lambda { Search.new(:junk, "That's Mr. Junk to You") }.should raise_error(PatRest::InvalidSearchType)
  end
end