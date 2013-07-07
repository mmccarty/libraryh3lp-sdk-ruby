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
      .to_return(:status => 200, :body => '[{"field1": "value1", "field2": "value2"}]')
    json, code = resource.list
    expect(code).to eq(200)
    expect(json).to eq([{'field1'=>'value1', 'field2'=>'value2'}])
  end

  it "list a given item" do
    resource = make_test_resource
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "value2"}')
    json, code = resource.read(1)
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'value2'})
  end

  it "create a new item" do
    resource = make_test_resource
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/foo")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"value2\"}")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "value2"}')
    json, code = resource.create({'field1' => 'value1', 'field2' => 'value2'})
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'value2'})
  end

  it "update an existing item" do
    resource = make_test_resource
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"mod_value\"}")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "mod_value"}')
    json, code = resource.update(1, {'field1' => 'value1', 'field2' => 'mod_value'})
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'mod_value'})
  end

  it "delete a given item" do
    resource = make_test_resource
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/foo/1")
      .to_return(:status => 200, :body => '{"response": "success"}')
    json, code = resource.destroy(1)
    expect(code).to eq(200)
    expect(json).to eq({'response' => 'success'})
  end
end
