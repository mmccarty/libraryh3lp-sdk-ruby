require "libraryh3lp/Resource"
require "webmock/rspec"
require "rspec"

def make_test_resource
  stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/auth/login").
    with(:body => {"password"=>"badpass", "username"=>"baduser"},
         :headers => {'Accept'=>'*/*; q=0.5, application/xml',
                      'Accept-Encoding'=>'gzip, deflate',
                      'Content-Length'=>'33',
                      'Content-Type'=>'application/x-www-form-urlencoded',
                      'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "", :headers => {})
  return Resource.new("unittest.libraryh3lp.com", "/foo", "baduser", "badpass")
end

describe Resource do
  it "list all items" do
    resource = make_test_resource
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/foo")
      .to_return(:status => 200, :body => "[{field1: 'value1', field2: 'value2'}]")
    expect(resource.list).to eq("[{field1: 'value1', field2: 'value2'}]")
  end

  it "list a given item" do
    resource = make_test_resource
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}")
    expect(resource.read(1)).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "create a new item" do
    resource = make_test_resource
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/foo")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"value2\"}")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}")
    expect(resource.create({"field1" => "value1", "field2" => "value2"})).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "update an existing itme" do
    resource = make_test_resource
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"mod_value\"}")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'mod_value'}")
    expect(resource.update(1, {"field1" => "value1", "field2" => "mod_value"})).to eq("{field1: 'value1', field2: 'mod_value'}")
  end

  it "delete a given item" do
    resource = make_test_resource
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .to_return(:status => 200, :body => "{response: 'success'}")
    expect(resource.delete(1)). to eq("{response: 'success'}")
  end
end
