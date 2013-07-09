require "libraryh3lp/Queues"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Queues do
  it "should be able to list operators" do
    queues = make_resource Queues
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/operators")
      .to_return(:status => 200, :body => '[{"queue": "some queue", "user" : "some user"}]')
    json, code = queues.listOperators(1)
    expect(code).to eq(200)
    expect(json).to eq([{'queue'=>'some queue', 'user'=>'some user'}])
  end

  it "should be able to create an operator" do
    queues = make_resource Queues
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/operators")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = queues.createOperator(1, {'user-id' => 1})
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to save an operator" do
    queues = make_resource Queues
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/operators/1")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = queues.updateOperator(1, 1, {enabled: false})
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to delete an operator" do
    queues = make_resource Queues
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/operators/1")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = queues.destroyOperator(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to list gateways" do
    queues = make_resource Queues
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/gateways")
      .to_return(:status => 200, :body => '[{"id": 1, "queue": "some queue"}]')
    json, code = queues.listGateways(1)
    expect(code).to eq(200)
    expect(json).to eq([{'id' => 1, 'queue' => 'some queue'}])
  end

  it "should be able to create a gateway" do
    queues = make_resource Queues
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/gateways")
      .to_return(:status => 200, :body => '{"id": 1, "protocol": "gtalk"}')
    json, code = queues.createGateway(1, {protocol: 'gtalk'})
    expect(code).to eq(200)
    expect(json).to eq({'id' => 1, 'protocol' => 'gtalk'})
  end

  it "should be able to delete a gateway" do
    queues = make_resource Queues
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/gateways/1")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = queues.destroyGateway(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'success' => true})
  end

  it "should be able to read a queue profile" do
    queues = make_resource Queues
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/profiles/staff")
      .to_return(:status => 200, :body => '<p>This is some html.</p>')
    response, code = queues.showProfile(1)
    expect(code).to eq(200)
    expect(response.to_str).to eq('<p>This is some html.</p>')
  end

  it "should be able to save a queue profile" do
    queues = make_resource Queues
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/queues/1/profiles/staff")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = queues.updateProfile(1, '<p>New profile.</p>')
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end
end
