require File.join(File.dirname(__FILE__), 'spec_helper')

describe "Flickr::Query class" do
  describe "without configuration" do
    it "should raise an exception when attempting a query" do
      lambda { @flickr = Flickr::Query.new('flickr.test.echo') }.should(raise_error(Flickr::Query::Failure))
    end
  end
  
  describe "with an api key" do
    before :all do
      Flickr::Query::CONFIG_PATH = File.join(File.dirname(__FILE__), 'supports', 'flickr-query.yml')
      @test = Flickr::Query.new('flickr.test.echo')
    end
    
    describe "raw response" do
      it "should be a string" do
        @test.raw.should(be_an_instance_of(String))
      end
    end
    
    describe "parsed response" do
      it "should return the flickr test method as a hash" do
        @test.parsed.should(be_an_instance_of(Hash))
      end
    
      it "should not have a stat" do
        @test.parsed.has_key?("stat").should be_false
      end
    
      it "should convert string keys to symbols" do
        @test.parsed.has_key?("api_key").should be_false
        @test.parsed.has_key?(:api_key).should be_true
      end
    
      it "should return exactly this" do
        @query = Flickr::Query.new("flickr.photosets.getList", :user_id => "36821533@N00", :photoset_id => "72157594298641954")
        @query.parsed.should == [{:title=>"Casper", :videos=>0, :server=>"3088", :primary=>"2672723214", :farm=>4, :description=>"Our puss, Casper the little ghost ", :photos=>"7", :id=>"72157613036698341", :secret=>"0f37af38af"}, {:title=>"The mountain house", :videos=>0, :server=>"3492", :primary=>"3211848622", :farm=>4, :description=>"My weekend project at Mt. Macedon", :photos=>"11", :id=>"72157612773309790", :secret=>"5094b55d86"}, {:title=>"Trip to the cross", :videos=>0, :server=>"3519", :primary=>"3210986937", :farm=>4, :description=>"Mt. Macedon memorial cross", :photos=>"4", :id=>"72157612773204566", :secret=>"9ec84474eb"}, {:title=>"Street", :videos=>0, :server=>"81", :primary=>"252076321", :farm=>1, :description=>"This project was created for the promotion of a graduating Bachelor of Arts – honours performance. As the performance project was solely self-developed, written, directed and performed, the visual ideas explored were that of the handmade and the presence of the 'hand of the artist' at work.\nThe original pattern forming the basis of the identity was taken from the work of William Morris. William Morris was concerned with the implications of the industrial revolution (and mass production) on the craftsmanship of the artist. This appears to be a commonly explored theme within the theatre arts community, and therefore formed the basis of the performance's identity.\nThe pattern was taken and distorted for our purposes with the cicadas from the performance's title taking part in the deconstruction of the pattern. The treatment gave a sinister edge to the original pattern and formed a kind of destructive two-level trompe l'oeil.", :photos=>"2", :id=>"72157603414539843", :secret=>"09785b9fca"}, {:title=>"Around HK", :videos=>0, :server=>"98", :primary=>"252091410", :farm=>1, :description=>"Convention centre, city streets and the harbour", :photos=>"5", :id=>"72157594298641954", :secret=>"ce956a8448"}]
      end
    end
  end
end

