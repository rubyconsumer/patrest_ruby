# PatREST client for Ruby
Client library for the [Ann Arbor District Library](http://www.aadl.org)'s [PatREST API](http://www.blyberg.net/downloads/patrest_1.3_overview.pdf).

## Installing

### Setup
Start by setting your library API's base url. For AADL, it's 'http://www.aadl.org/rest/'

    require 'patrest'
    include PatRest
    PatRest::OPTIONS = {'BASE_URI' => http://www.aadl.org/rest/}
    
### Finding Records
You can find a specific record by it's id

    Record.find(1250150).inspect
    # =>  #<PatRest::Record:0x111fc28 @attributes={"xmlns:p"=>"http://www.aadl.org", "bibnum"=>"1250150", "pubinfo"=>"New York : Little, Brown and Co., 2005", "isbn"=>"0316160172", "recordlink"=>"http://www.aadl.org/cat/seek/record=1250150", "callnum"=>"Teen Fiction", "copies"=>"61", "xmlns:xlink"=>"http://www.w3.org/1999/xlink", "title"=>"Twilight", "price"=>"$17.99", "holds"=>"80", "author"=>"Meyer, Stephenie, 1973-", "catdate"=>"10-03-2005", "avail"=>"7 copies available at Malletts Adult, Traverwood Adult and West Adult", "series"=>"Twilight saga ; 1", "subject"=>["Vampires -- Fiction", "High schools -- Fiction", "Washington (State) -- Fiction"], "desc"=>"498 p", "summary"=>"When seventeen-year-old Bella leaves Phoenix to live with her father in Forks, Washington, she meets an exquisitely handsome boy at school for whom she feels an overwhelming attraction and who she comes to realize is not wholly human", "lang"=>"eng", "ccimglink"=>"http://www.aadl.org/cat/ccimg/1250150", "edition"=>"1st ed", "mattype"=>"a", "fulltitle"=>"Twilight / a novel by Stephenie Meyer", "coverimglink"=>"http://syndetics.com/hw7.pl?isbn=0316160172+A/SC.gif"}>
    
### Data access
Access data with dot notation for attributes

    record = Record.find(1250150)
    record.title
    #=> "Twilight"
    record.subject
    #=> ["Vampires -- Fiction", "High schools -- Fiction", "Washington (State) -- Fiction"]

### Search
You can perform any of the PatREST search types

    search = Search.new(:title, 'twilight')
    search.execute
    search.first
    # => <PatRest::Record:0x10a65a8 @attributes={"bibnum"=>"1286255", "recordlink"=>"http://www.aadl.org/cat/seek/record=1286255", "xlink:href"=>"http://www.aadl.org/rest/record/1286255/", "title"=>"Rapunzel, the one with all the hair", "xmlrecordlink"=>"http://www.aadl.org/rest/record/1286255/", "author"=>nil, "id"=>"1286255", "xlink:title"=>"Rapunzel, the one with all the hair / Wendy Mass", "fulltitle"=>"Rapunzel, the one with all the hair / Wendy Mass"}>
    
### Patron-specific data
Patron data access requires the patron's token.

    patron = Patron.new('1234567abcedef')
    patron.holds
    # => <PatRest::Record:0x1122630 @attributes={"bibnum"=>"1067614", "isbn"=>"$48.00", "recordlink"=>"http://www.aadl.org/cat/seek/record=1067614", "xlink:href"=>"http://www.aadl.org/rest/record/1067614/", "title"=>"Envisioning information", "xmlrecordlink"=>"http://www.aadl.org/rest/record/1067614/", "author"=>"Tufte, Edward R., 1942-", "id"=>"1067614", "xlink:title"=>"Envisioning information / Edward R. Tufte", "imglink"=>"http://syndetics.com/hw7.pl?isbn=$48.00+A/SC.gif", "pickuploc"=>"Downtown Library", "canceldate"=>"2010-04-12", "fulltitle"=>"Envisioning information / Edward R. Tufte", "holdstatus"=>"2 of 4 holds"}>
    patron.items.first
    # => #<PatRest::Record:0x1040a00 @attributes={"bibnum"=>"1277702", "recordlink"=>"http://www.aadl.org/cat/seek/record=1277702", "xlink:href"=>"http://www.aadl.org/rest/record/1277702/", "title"=>"Make [periodical]: technology on your time", "xmlrecordlink"=>"http://www.aadl.org/rest/record/1277702/", "author"=>nil, "id"=>"1277702", "xlink:title"=>"Make [periodical]: technology on your time", "duedate"=>"2009-05-02", "fulltitle"=>"Make [periodical]: technology on your time"}>
    
    
    