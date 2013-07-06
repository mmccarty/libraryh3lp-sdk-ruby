require 'libraryh3lp/Resource'

class Accounts < Resource
  def initialize(host, username, passwd)
    super host, 'accounts', username, passwd
  end
end
