# Introduction

flickr-rest is a stab at removing all the stuff that you don't really
want to do. There are no specific photo methods, community. Nothing.

Simply use it to query the bits you want. 
If you want a flickr api wrapper, use the flickr gem.

# Usage

    require 'flickr-rest'
    Flickr::Query::CONFIG_PATH = '/path/to/flickr.yml'
    flickr = Flickr::Query.new('flickr.test.echo')

    # Raw JSON response (String)
    flickr.raw
    => '{"api_key":{"_content":"2b60171843b346aa104e3a38d0129e5e"}, "format":{"_content":"json"}, "nojsoncallback":{"_content":"1"}, "method":{"_content":"flickr.test.echo"}, "stat":"ok"}'

    # A clean, tidy ruby object
    flickr.parsed
    => {:api_key=>"2b60171843b346aa104e3a38d0129e5e", :format=>"json", :method=>"flickr.test.echo", :nojsoncallback=>"1"}


