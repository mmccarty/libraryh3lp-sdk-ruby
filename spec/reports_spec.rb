require "libraryh3lp/Reports"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Reports do
  it "should be able to report chats per hour" do
    reports = make_resource Reports
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/reports/chats-per-hour?notanswered=false&queues=%5B1,%202,%203%5D&sysmsg=false")
      .to_return(:status => 200, :body => 'hour,Sun,Mon,Tue,Wed,Thu,Fri,Sat\n0,1,66,60,70,51,50,0')
    response, code = reports.chatsPerHour({queues: [1, 2, 3]})
    expect(code).to eq(200)
    expect(response.to_str).to eq('hour,Sun,Mon,Tue,Wed,Thu,Fri,Sat\n0,1,66,60,70,51,50,0')
  end

  it "should be able to report chats per month" do
    reports = make_resource Reports
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/reports/chats-per-month?notanswered=false&queues=%5B1,%202,%203%5D&sysmsg=false")
      .to_return(:status => 200, :body => 'protocol,10/2008\nweb,100')
    response, code = reports.chatsPerMonth({queues: [1, 2, 3]})
    expect(code).to eq(200)
    expect(response.to_str).to eq('protocol,10/2008\nweb,100')
  end

  it "should be able to report chats per protocol" do
    reports = make_resource Reports
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/reports/chats-per-protocol?notanswered=false&queues=%5B1,%202,%203%5D&sysmsg=false")
      .to_return(:status => 200, :body => 'protocol,chats\nweb,100\nxmpp,100')
    response, code = reports.chatsPerProtocol({queues: [1, 2, 3]})
    expect(code).to eq(200)
    expect(response.to_str).to eq('protocol,chats\nweb,100\nxmpp,100')
  end

  it "should be able to report chats per queue" do
    reports = make_resource Reports
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/reports/chats-per-queue?notanswered=false&queues=%5B1,%202,%203%5D&sysmsg=false")
      .to_return(:status => 200, :body => 'queue,Jan,Feb,etc\nqueue1,100,100,...')
    response, code = reports.chatsPerQueue({queues: [1, 2, 3]})
    expect(code).to eq(200)
    expect(response.to_str).to eq('queue,Jan,Feb,etc\nqueue1,100,100,...')
  end

  it "should be able to report chats per operator" do
    reports = make_resource Reports
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/reports/chats-per-operator?notanswered=false&queues=%5B1,%202,%203%5D&sysmsg=false")
      .to_return(:status => 200, :body => 'operator,n,mean,median,etc\nop1,100,1,1,...')
    response, code = reports.chatsPerOperator({queues: [1, 2, 3]})
    expect(code).to eq(200)
    expect(response.to_str).to eq('operator,n,mean,median,etc\nop1,100,1,1,...')
  end
end
