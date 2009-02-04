require 'json'
require 'open-uri'

module Flickr
  class Query
    VERSION       = "0.2.0".freeze
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
      raise Failure, response["message"] if response["stat"] == "fail"
      return response
    end
  
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
  end
end