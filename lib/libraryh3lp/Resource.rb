require "rest-client"

VERSION = '/2011-12-03'

class Resource

  def initialize (host, baseurl, username, passwd)
    @host    = host
    @baseurl = baseurl
    @site    = RestClient::Resource.new 'https://' + host + VERSION
    response = @site['/auth/login'].post :username => username, :password => passwd
    @cookies = response.cookies
  end

  def list
    @site[@baseurl].get( :cookies => @cookies)
  end

  def read (id)
    @site[@baseurl + "/#{id}"].get( :cookies => @cookies)
  end

end
