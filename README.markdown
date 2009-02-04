# Introduction

flickr-rest is a stab at removing all the stuff that you don't really
want to do. There are no specific photo methods, community. Nothing.

Simply use it to query the bits you want. 
If you want a flickr api wrapper, use the flickr gem.

# Usage

    require 'flickr-rest'
    Flickr::Query::CONFIG_PATH = '/path/to/flickr.yml'
    flickr = Flickr::Query.new

    flickr.request('flickr.test.echo') 



