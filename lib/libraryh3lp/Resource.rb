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

  %w(get post put delete).each do |name|
    define_method name do |url, *args|
      args = attach_cookie(*args)
      response = @site[url != '' ? "#{ @baseurl }/#{ url }" : "#{ @baseurl }"].send name, *args
      return response, response.code
    end

    define_method "#{ name }_json" do |url, *args|
      args = attach_cookie(*args)
      json { send name, url, *args }
    end
  end

  def json
    response, code = yield
    return JSON.parse(response.to_str), code
  end

  def attach_cookie(*args)
    if not args.empty?
      args[-1] = args.last.merge(cookies: @cookies)
    else
      args.push(cookies: @cookies)
    end
    return args
  end

  def opt_params(params)
    params.delete_if { |k, v| v.nil? }
  end

  def list
    get_json ''
  end

  def read(id)
    get_json "#{ id }"
  end

  def create(data)
    post_json '', JSON.dump(data), content_type: :json, accept: :json
  end

  def update(id, data)
    put_json "#{ id }", JSON.dump(data), content_type: :json, accept: :json
  end

  def destroy(id)
    delete_json "#{ id }"
  end
end
