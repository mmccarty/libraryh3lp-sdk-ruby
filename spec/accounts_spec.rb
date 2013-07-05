require "libraryh3lp/Accounts"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Accounts do
  it "list all accounts" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "[{field1: 'value1', field2: 'value2'}]", :headers => {})
    expect(resource.list).to eq("[{field1: 'value1', field2: 'value2'}]")
  end

  it "list a given item" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}", :headers => {})
    expect(resource.read(1)).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "create a new item" do
    resource = make_resource Accounts
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/accounts").
      with(:body => "{\"field1\":\"value1\",\"field2\":\"value2\"}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'37', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}", :headers => {})
    expect(resource.create({"field1" => "value1", "field2" => "value2"})).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "update an existing itme" do
    resource = make_resource Accounts
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1").
      with(:body => "{\"field1\":\"value1\",\"field2\":\"mod_value\"}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'40', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{field1: 'value1', field2: 'mod_value'}", :headers => {})
    expect(resource.update(1, {"field1" => "value1", "field2" => "mod_value"})).to eq("{field1: 'value1', field2: 'mod_value'}")
  end

  it "delete a given item" do
    resource = make_resource Accounts
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{response: 'success'}", :headers => {})
    expect(resource.delete(1)). to eq("{response: 'success'}")
  end
end
