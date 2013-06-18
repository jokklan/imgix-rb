require 'digest'
require 'addressable/uri'

module Imgix
  class Client
    def initialize(options = {})
      @host = options[:host]
      @token = options[:token]
      @secure = options[:secure]
    end

    def sign_path(path)
      uri = Addressable::URI.parse(path)
      query = (uri.query || '')
      signature = Digest::MD5.hexdigest(@token + uri.path + '?' + query)
      "#{@secure ? 'https' : 'http'}://#{@host}#{uri.path}?#{query}#{query.length > 0 ? '&' : ''}s=#{signature}"
    end
  end
end