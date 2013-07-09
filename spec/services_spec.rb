require "libraryh3lp/Services"
require "test_utils"
require "webmock/rspec"
require "rspec"

describe Services do
  it "should be able to list service levels" do
    services = make_resource Services
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels")
      .to_return(:status => 200, :body => '[{"serviceId": 1, "name" : "foo"}]')
    json, code = services.listServiceLevels(1)
    expect(code).to eq(200)
    expect(json).to eq([{'serviceId'=>1, 'name'=>'foo'}])
  end

  it "should be able to show a service level" do
    services = make_resource Services
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels/1")
      .to_return(:status => 200, :body => '{"serviceId": 1, "name" : "foo"}')
    json, code = services.showServiceLevel(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'serviceId'=>1, 'name'=>'foo'})
  end

  it "should be able to create a service level" do
    services = make_resource Services
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels")
      .to_return(:status => 200, :body => '{"serviceId": 1, "name" : "foo"}')
    json, code = services.createServiceLevel(1, {name: 'foo'})
    expect(code).to eq(200)
    expect(json).to eq({'serviceId'=>1, 'name'=>'foo'})
  end

  it "should be able to save a service level" do
    services = make_resource Services
    stub_request(:put, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels/1")
      .to_return(:status => 200, :body => '{"serviceId": 1, "name" : "bar"}')
    json, code = services.saveServiceLevel(1, 1, {name: 'bar'})
    expect(code).to eq(200)
    expect(json).to eq({'serviceId'=>1, 'name'=>'bar'})
  end

  it "should be able to delete a service level" do
    services = make_resource Services
    stub_request(:delete, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels/1")
      .to_return(:status => 200, :body => '{"success": true}')
    json, code = services.deleteServiceLevel(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'success'=>true})
  end

  it "should be able to up a service level" do
    services = make_resource Services
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels/1/up")
      .to_return(:status => 200, :body => '{"serviceId": 1, "name" : "foo", "level" : 2}')
    json, code = services.upServiceLevel(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'serviceId'=>1, 'name'=>'foo', 'level'=>2})
  end

  it "should be able to down a service level" do
    services = make_resource Services
    stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/services/1/levels/1/down")
      .to_return(:status => 200, :body => '{"serviceId": 1, "name" : "foo", "level" : 1}')
    json, code = services.downServiceLevel(1, 1)
    expect(code).to eq(200)
    expect(json).to eq({'serviceId'=>1, 'name'=>'foo', 'level'=>1})
  end

  it "should be able to list service types" do
    services = make_resource Services
    stub_request(:get, "https://unittest.libraryh3lp.com/2011-12-03/service-types")
      .to_return(:status => 200, :body => '[{"id": 1, "name" : "foo"}]')
    json, code = services.listServiceTypes()
    expect(code).to eq(200)
    expect(json).to eq([{'id'=>1, 'name'=>'foo'}])
  end
end
