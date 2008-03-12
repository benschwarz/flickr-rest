require 'rubygems'
require 'hpricot'
require 'open-uri'

module Flickr
  class Query
    VERSION = '0.0.1'
    API_BASE = "http://api.flickr.com/services/rest/"
    API_KEY = "2b60171843b346aa104e3a38d0129e5e"
    class Failure < StandardError; end
    
    # @param user_id - Your flickr user id
    def initialize(user_id)
      @user_id = user_id
    end
    
    # @param api_method - flickr.test.echo
    # @param params={}  - :photo_id => 2929112139
    def execute(api_method, params={})
      dispatch(build_query(api_method, params))
    end

    private
    def dispatch(query)
      puts query
      response = Hpricot.XML(open(query).read)
      raise Failure, response.at(:err)['msg'] unless response.search(:err).empty?
      return response
    end
  
    def build_query(method, params={})
      url = []
        opts = {
        :method => method,
        :api_key => API_KEY,
        :user_id => @user_id,
      }.merge(params).each do |key, value|
        url << "#{key}=#{value}"
      end

      return API_BASE + "?" + url.join("&")
    end
  end
end