require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::Query, "class" do
  before :all do
    # my user
    @flickr = Flickr::Query.new '36821533@N00'
  end
  
  it "should return the flickr test method as a hpricot document" do
    @flickr.execute('flickr.test.echo').should be_an_instance_of Hpricot::Doc
  end
end