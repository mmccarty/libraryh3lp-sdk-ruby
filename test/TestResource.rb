require "../lib/libraryh3lp/Resource"
require "test/unit"

class FakeRestResponse

  def initialize(content = nil)
    @cookies = {"libraryh3lp-session" => "fake"}
    @content = content
  end

  def content
    @content
  end

  def cookies
    @cookies
  end
end

class FakeRestRequest

  def [](key)
    self
  end

  def post(*args)
    return FakeRestResponse.new
  end

  def get(*args)
    return FakeRestResponse.new(content = [{"field1" => "value1", "field2" => "value2"}])
  end
end

class TestResource < Test::Unit::TestCase

  def setup
    @resource = Resource.new("test.libraryh3lp.com",
                             "/foo",
                             "baduser",
                             "badpass",
                             rest_resource = FakeRestRequest.new)
  end

  def test_initialize_auth_failure
    r = Resource.new "test.libraryh3lp.com", "/foo", "baduser", "badpass"
    assert_equal "", r.cookies["libraryh3lp-session"]
  end

  def test_initialize_with_fake_rest_resource
    assert_equal "fake", @resource.cookies["libraryh3lp-session"]
  end

  def test_list
    assert_equal [{"field1" => "value1", "field2" => "value2"}], @resource.list.content
  end

  def test_read
    assert_equal [{"field1" => "value1", "field2" => "value2"}], @resource.read(1).content
  end
end
