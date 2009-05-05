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
  
  describe 'seeing checked out items' do
    it 'returns an array if there are many items' do
      mock_http(:get, "/checkouts/123456789abcdef", 'patron_checkouts_with_many_items.xml')
      @patron.items.should be_kind_of(Array)
      @patron.items[0].should be_kind_of(Record)
    end
    
    it 'shows an array if there is one item' do
      mock_http(:get, "/checkouts/123456789abcdef", 'patron_checkouts_with_one_item.xml')
      @patron.items.should be_kind_of(Array)
      @patron.items[0].should be_kind_of(Record)
    end
  end
  
  describe 'seeing held items' do
    it 'returns an array if there are many items' do
      mock_http(:get, "/holds/123456789abcdef", 'patron_holds_with_many_items.xml')
      @patron.holds.should be_kind_of(Array)
      @patron.holds[0].should be_kind_of(Record)
    end
    
    it 'returns an array if there is one item' do
      mock_http(:get, "/holds/123456789abcdef", 'patron_holds_with_one_item.xml')
      @patron.holds.should be_kind_of(Array)
      @patron.holds[0].should be_kind_of(Record)
    end
  end
end