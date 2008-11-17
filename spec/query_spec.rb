require File.join(File.dirname(__FILE__), 'spec_helper')

describe "Flickr::Query class" do
  before do
    @flickr = Flickr::Query.new '36821533@N00'
  end
  
  describe "without an api key" do
    it "should raise an exception when attempting a query" do
      lambda { @flickr.execute('flickr.test.echo') }.should(raise_error)
    end
  end
  
  describe "with an api key" do
    before do
      Flickr::Query::API_KEY = '2b60171843b346aa104e3a38d0129e5e'
    end
    
    it "should return the flickr test method as a hpricot document" do
      @flickr.execute('flickr.test.echo').should be_an_instance_of(Hpricot::Doc)
    end
  end
end

