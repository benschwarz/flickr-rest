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
      @test = Flickr::Query.new.request('flickr.test.echo')
    end
    
    it "should return the flickr test method as a hash" do
      @test.should(be_an_instance_of(Hash))
    end
    
    it "should not have a stat" do
      @test.has_key?("stat").should be_false
    end
    
    it "should convert string keys to symbols" do
      @test.has_key?("api_key").should be_false
      @test.has_key?(:api_key).should be_true
    end
  end
end

