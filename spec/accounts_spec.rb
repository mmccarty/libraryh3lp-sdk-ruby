require "libraryh3lp/Accounts"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Accounts do
  it "list all accounts" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts")
      .to_return(:status => 200, :body => "[{field1: 'value1', field2: 'value2'}]")
    expect(resource.list).to eq("[{field1: 'value1', field2: 'value2'}]")
  end

  it "list a given item" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}")
    expect(resource.read(1)).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "create a new item" do
    resource = make_resource Accounts
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/accounts")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"value2\"}")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'value2'}")
    expect(resource.create({"field1" => "value1", "field2" => "value2"})).to eq("{field1: 'value1', field2: 'value2'}")
  end

  it "update an existing itme" do
    resource = make_resource Accounts
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"mod_value\"}")
      .to_return(:status => 200, :body => "{field1: 'value1', field2: 'mod_value'}")
    expect(resource.update(1, {"field1" => "value1", "field2" => "mod_value"})).to eq("{field1: 'value1', field2: 'mod_value'}")
  end

  it "delete a given item" do
    resource = make_resource Accounts
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .to_return(:status => 200, :body => "{response: 'success'}")
    expect(resource.delete(1)). to eq("{response: 'success'}")
  end
end
