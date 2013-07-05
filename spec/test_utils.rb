def make_resource (object)
  stub_request(:post, "https://unittest.libraryh3lp.com/2011-12-03/auth/login").
    with(:body => {"password"=>"badpass", "username"=>"baduser"},
         :headers => {'Accept'=>'*/*; q=0.5, application/xml',
                      'Accept-Encoding'=>'gzip, deflate',
                      'Content-Length'=>'33',
                      'Content-Type'=>'application/x-www-form-urlencoded',
                      'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "", :headers => {})
  return object.new("unittest.libraryh3lp.com", "baduser", "badpass")
end
