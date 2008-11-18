begin
  require 'minigems'
rescue LoadError
  require 'rubygems'
end

require 'hpricot'
require 'open-uri'

module Flickr
  class Query
    VERSION = '0.1.1'
    API_BASE = "http://api.flickr.com/services/rest/"
    
    class Failure < StandardError; end
    class ApiKeyRequired < StandardError; end
    
    # @param user_id - Your flickr user id
    def initialize(user_id)
      @user_id = user_id
    end
    
    # @param api_method eg: flickr.test.echo
    # @param params={}  eg: :photo_id => 2929112139
    def execute(api_method, params={})
      raise ApiKeyRequired, "set your flickr API key using Flickr::Query.API_KEY = ''" if API_KEY.nil?
      
      dispatch(build_query(api_method, params)) 
    end

    private
    def dispatch(query)
      response = Hpricot.XML(open(query).read)
      raise Failure, response.at(:err)['msg'] unless response.search(:err).empty?
      return response
    end
  
    def build_query(method, params={})
      url = []
      opts = {
        :method => method,
        :api_key => API_KEY,
        :user_id => @user_id
      }.merge(params).each do |key, value|
        url << "#{key}=#{value}" unless value.nil?
      end

      return API_BASE + "?" + url.join("&")
    end
  end
end