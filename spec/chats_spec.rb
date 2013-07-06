require "libraryh3lp/Chats"
require "webmock/rspec"
require "rspec"
require "test_utils"

describe Chats do
  it "list all chats for a given day" do
    resource = make_resource Chats
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/conversations/2013/07/03?format=json")
      .to_return(:status => 200, :body => '[{"chat": 1}, {"chat": 2}]')
    json, code = resource.listDay(2013, 7, 3)
    expect(code).to eq(200)
    expect(json).to eq([{'chat' => 1}, {'chat' => 2}])
  end

  it "list all chats for a given month" do
    resource = make_resource Chats
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/conversations/2013/07")
      .to_return(:status => 200, :body => '[{"chat": 1}, {"chat": 2}]')
    json, code = resource.listMonth(2013, 7)
    expect(code).to eq(200)
    expect(json).to eq([{'chat' => 1}, {'chat' => 2}])
  end

  it "list all chats for a given year" do
    resource = make_resource Chats
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/conversations/2013")
      .to_return(:status => 200, :body => '[{"chat": 1}, {"chat": 2}]')
    json, code = resource.listYear(2013)
    expect(code).to eq(200)
    expect(json).to eq([{'chat' => 1}, {'chat' => 2}])
  end

  it "anonymizes a give chat" do
    resource = make_resource Chats
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/conversations/anonymize-conversations")
      .with(:body => {"ids"=>"1,2,3"})
      .to_return(:status => 200, :body => '{"response": "success"}')
    json, code = resource.anonymizeChats([1, 2, 3])
    expect(code).to eq(200)
    expect(json).to eq({'response' => 'success'})
  end

  it "deletes chats" do
    resource = make_resource Chats
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/conversations/delete-conversations")
      .with(:body => {"ids"=>"1,2,3"})
      .to_return(:status => 200, :body => '{"response": "success"}')
    json, code = resource.deleteChats([1, 2, 3])
    expect(code).to eq(200)
    expect(json).to eq({'response' => 'success'})
  end

  it "deletes transcript" do
    resource = make_resource Chats
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/conversations/delete-transcripts")
      .with(:body => {"ids"=>"1,2,3"})
      .to_return(:status => 200, :body => '{"response": "success"}')
    json, code = resource.deleteTranscripts([1, 2, 3])
    expect(code).to eq(200)
    expect(json).to eq({'response' => 'success'})
  end

  it "archive conversations" do
    resource = make_resource Chats
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/conversations/archive?ids=1,2,3")
      .to_return(:status => 200, :body => "here you go")
    response, code = resource.archiveConversations([1, 2, 3])
    expect(code).to eq(200)
    expect(response.to_str).to eq("here you go")
  end
end
