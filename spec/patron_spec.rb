require File.dirname(__FILE__) + '/spec_helper'

describe Patron do
  it "needs a token to initialize" do
    lambda { Patron.new() }.should raise_error
  end
end

describe Patron, "accessing account data" do
  before do
    @patron = Patron.new('123456789abcdef')
  end
  
  it "can provide an array of checked out items" do
    mock_http(:get, "/checkouts/123456789abcdef", 'patron_checkouts.xml')
    @patron.items.should be_kind_of(Array)
    @patron.items[0].should be_kind_of(Record)
    
  end
  
  it "can provide an array of items on hold" do
    mock_http(:get, "/holds/123456789abcdef", 'patron_holds_with_one_item.xml')
    @patron.holds.should be_kind_of(Array)
    @patron.holds[0].should be_kind_of(Record)
  end
end