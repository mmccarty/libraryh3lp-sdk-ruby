require "../lib/libraryh3lp/Resource"
require "webmock/test_unit"
require "test/unit"

class TestResource < Test::Unit::TestCase

  def setup
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/auth/login").
      with(:body => {"password"=>"badpass", "username"=>"baduser"},
           :headers => {'Accept'=>'*/*; q=0.5, application/xml',
                        'Accept-Encoding'=>'gzip, deflate',
                        'Content-Length'=>'33',
                        'Content-Type'=>'application/x-www-form-urlencoded',
                        'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})
    @resource = Resource.new("unittest.libraryh3lp.com",
                             "/foo",
                             "baduser",
                             "badpass")
  end

  def test_list
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/foo").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "[{field1: 'value1', field2: 'value2'}]", :headers => {})
    assert_equal "[{field1: 'value1', field2: 'value2'}]", @resource.list
  end

  def test_read
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/foo/1").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}", :headers => {})
    assert_equal "{field1: 'value1', field2: 'value2'}", @resource.read(1)
  end
end
