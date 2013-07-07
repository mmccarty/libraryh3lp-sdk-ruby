require "libraryh3lp/Accounts"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Accounts do
  it "list all accounts" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts")
      .to_return(:status => 200, :body => '[{"field1": "value1", "field2": "value2"}]')
    json, code = resource.list
    expect(code).to eq(200)
    expect(json).to eq([{'field1'=>'value1', 'field2'=>'value2'}])
  end

  it "list a given account" do
    resource = make_resource Accounts
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "value2"}')
    json, code = resource.read(1)
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'value2'})
  end

  it "create a new account" do
    resource = make_resource Accounts
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/accounts")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"value2\"}")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "value2"}')
    json, code = resource.create({'field1' => 'value1', 'field2' => 'value2'})
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'value2'})
  end

  it "update an existing account" do
    resource = make_resource Accounts
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .with(:body => "{\"field1\":\"value1\",\"field2\":\"mod_value\"}")
      .to_return(:status => 200, :body => '{"field1": "value1", "field2": "mod_value"}')
    json, code = resource.update(1, {'field1' => 'value1', 'field2' => 'mod_value'})
    expect(code).to eq(200)
    expect(json).to eq({'field1'=>'value1', 'field2'=>'mod_value'})
  end

  it "delete a given account" do
    resource = make_resource Accounts
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/accounts/1")
      .to_return(:status => 200, :body => '{"response": "success"}')
    json, code = resource.destroy(1)
    expect(code).to eq(200)
    expect(json).to eq({'response' => 'success'})
  end
end
