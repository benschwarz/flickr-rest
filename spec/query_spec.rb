require File.join(File.dirname(__FILE__), 'spec_helper')

describe "Flickr::Query class" do
  describe "without configuration" do
    it "should raise an exception when attempting a query" do
      lambda { @flickr = Flickr::Query.new }.should(raise_error(Flickr::Query::Failure))
    end
  end
  
  describe "with an api key" do
    before :all do
      Flickr::Query::CONFIG_PATH = File.join(File.dirname(__FILE__), 'supports', 'flickr-query.yml')
      @flickr = Flickr::Query.new
    end
    
    it "should return the flickr test method as a hash" do
      @flickr.request('flickr.test.echo').should(be_an_instance_of(Hash))
    end
    
    it "should have a stat of 'ok'" do
      @flickr.request("flickr.test.echo")["stat"].should(eql("ok"))
    end
  end
end

