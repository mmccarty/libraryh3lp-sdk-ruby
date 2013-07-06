def make_resource (object)
  stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/auth/login")
    .with(:body => {"password"=>"badpass", "username"=>"baduser"})
    .to_return(:status => 200, :body => "")
  return object.new("unittest.libraryh3lp.com", "baduser", "badpass")
end
