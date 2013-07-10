require "libraryh3lp/Presence"
require "webmock/rspec"
require "rspec"
require "test_utils"

describe Presence do
  it "should be able to check presence in text format" do
    presence = make_resource Presence
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/presence/jid/some-name/some-host/text")
      .to_return(:status => 200, :body => 'avaliable')
    response, code = presence.check('some-name', 'some-host', 'text')
    expect(code).to eq(200)
    expect(response.to_str).to eq('avaliable')
  end

  it "should be able to check presence in xml format" do
    presence = make_resource Presence
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/presence/jid/some-name/some-host/xml")
      .to_return(:status => 200, :body => '<xml></xml>')
    response, code = presence.check('some-name', 'some-host', 'xml')
    expect(code).to eq(200)
    expect(response.to_str).to eq('<xml></xml>')
  end

  it "should be able to check presence in js format" do
    presence = make_resource Presence
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/presence/jid/some-name/some-host/js")
      .to_return(:status => 200, :body => 'var js = blah blah blah;')
    response, code = presence.check('some-name', 'some-host', 'js')
    expect(code).to eq(200)
    expect(response.to_str).to eq('var js = blah blah blah;')
  end
end
