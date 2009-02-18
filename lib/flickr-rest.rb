require 'rubygems'
require 'json'
require 'open-uri'

module Flickr
  class Query
    VERSION       = "0.2.1".freeze
    API_BASE      = "http://api.flickr.com/services/rest/".freeze
    
    class Failure < StandardError; end

    # @param api_method eg: flickr.test.echo
    # @param params={}  eg: :photo_id => 2929112139
    def initialize
      @@config ||= YAML::load(File.open(CONFIG_PATH))
    rescue NameError
      raise Failure, "set your flickr API key and shared secret with a YAML file and point it to Flickr::Query.CONFIG_PATH = 'my-config.yml'"
    end
    
    def request(api_method, params = {})
      response = JSON.parse(open(build_query(api_method, params)).read)
      raise Failure, response["message"] if response.delete("stat") == "fail"
      name, response = response.to_a.first if response.size == 1
      
      unnest(response)
    end
    
    private
    def build_query(method, params={})
      url = []
      opts = {
        :method => method,
        :nojsoncallback => 1,
        :format => "json"
      }.merge(params).merge(@@config).each do |key, value|
        url << "#{key}=#{value}" unless value.nil?
      end

      return API_BASE + "?" + url.join("&")
    end
    
    def unnest(h)
      return h unless h.is_a? Hash
      if h.keys == ["_content"]
        h["_content"]
      else
        h.inject({}) do |h, kv|
          k,v = *kv
          h[k.to_sym] = unnest(v)
          h
        end
      end
    end
    
  end
end