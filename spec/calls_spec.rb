require "libraryh3lp/Calls"
require "webmock/rspec"
require "rspec"
require "test_utils"

describe Calls do
  it "should be able to email a transcript" do
    calls = make_resource Calls
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/queues/some-queue/calls/some-guest/some-chat/mail")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = calls.emailTranscript('some-queue', 'some-guest', 'some-chat', 'someone@email.com')
    expect(code).to eq(200)
    expect(json).to eq({'success' => true})
  end

  it "should be able to send a file" do
    calls = make_resource Calls
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/queues/some-queue/calls/some-guest/some-chat/file")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = calls.sendFile('some-queue', 'some-guest', 'some-chat', 'README.md')
    expect(code).to eq(200)
    expect(json).to eq({'success' => true})
  end

  it "should be able to list users and queues able to accept a transfer" do
    calls = make_resource Calls
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/queues/some-queue/calls/some-guest/some-chat/transfer")
      .to_return(:status => 200, :body => '{"queues": ["test-queue1@chat.mycustomercloud.com", "test-queue2@chat.mycustomercloud.com"], "users": ["another-operator@mycustomercloud.com"]}')
    json, code = calls.listTransferTargets('some-queue', 'some-guest', 'some-chat')
    expect(code).to eq(200)
    expect(json).to eq({'queues'=>['test-queue1@chat.mycustomercloud.com', 'test-queue2@chat.mycustomercloud.com'], 'users'=>['another-operator@mycustomercloud.com']})
  end

  it "should be able to transfer a chat" do
    calls = make_resource Calls
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/queues/some-queue/calls/some-guest/some-chat/transfer")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = calls.transfer('some-queue', 'some-guest', 'some-chat', 'some-queue@chat.libraryh3lp.com')
    expect(code).to eq(200)
    expect(json).to eq({'success' => true})
  end

  it "should be able to view a transcript" do
    calls = make_resource Calls
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/queues/some-queue/calls/some-guest/some-chat")
      .to_return(:status => 200, :body => '10:16 5189487901334778072897@mycustomercloud.com Hi')
    response, code = calls.viewTranscript('some-queue', 'some-guest', 'some-chat')
    expect(code).to eq(200)
    expect(response.to_str).to eq('10:16 5189487901334778072897@mycustomercloud.com Hi')
  end
end
