require 'json'
require 'rest-client'

VERSION = '2011-12-03'

class Resource
  attr_reader :cookies

  def initialize(host, baseurl, username, passwd)
    @host    = host
    @baseurl = baseurl
    @site    = RestClient::Resource.new "https://#{ host }/#{ VERSION }"
    response = @site['auth/login'].post username: username, password: passwd
    @cookies = response.cookies
  end

  %w(get post).each do |name|
    define_method name do |url, *args|
      response = @site["#{ @baseurl }/#{ url }"].send name, *args
      return response, response.code
    end

    define_method "#{ name }_json" do |url, *args|
      json { send name, url, *args }
    end
  end

  def json
    response, code = yield
    return JSON.parse(response.to_str), code
  end

  def opt_params(params)
    params.delete_if { |k, v| v.nil? }
  end

  def list
    @site[@baseurl].get cookies: @cookies
  end

  def read(id)
    @site["#{ @baseurl }/#{ id }"].get cookies: @cookies
  end

  def create(data)
    @site[@baseurl].post JSON.dump(data), content_type: :json, accept: :json
  end

  def update(id, data)
    @site["#{ @baseurl }/#{ id }"].put JSON.dump(data), content_type: :json, accept: :json
  end

  def delete(id)
    @site["#{ @baseurl }/#{ id }"].delete
  end
end
