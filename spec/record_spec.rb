require File.dirname(__FILE__) + '/spec_helper'

describe Record do
  describe "finding" do
    describe "with a valid key" do
      before  do
        @id = 1250150
        mock_http(:get, "#{@id}", 'record_twilight.xml')
      end
      
      it "raises no errors" do
        lambda { Record.find(@id) }.should_not raise_error
      end
      
      it "returns a PatRest::Record object" do
        Record.find(@id).should be_kind_of(PatRest::Record)
      end
    end
    
    describe "with an invalid key" do
      it "rasies PatRest::RecordNotFound" do
        id = 1
        mock_http(:get, "http://www.aadl.org/rest/record/#{id}", 'record_not_found.xml')
        lambda { Record.find(id) }.should raise_error(PatRest::RecordNotFound)
      end
    end
  end
  
  describe "attribute access" do
    before  do
      @id = 1250150
      mock_http(:get, "http://www.aadl.org/rest/record/#{@id}", 'record_twilight.xml')
      @record = Record.find(@id)
    end
    
    it 'can occur with dot notation' do
      @record.bibnum.should_not be_nil
    end
    
    it 'can occur through the attributes method' do
      @record.attributes['bibnum'].should_not be_nil
    end
    
    it 'raises NoMethodError on unknow attributes' do
      lambda { @record.foobarbaz }.should raise_error(NoMethodError)
    end
  end
end