require 'libraryh3lp/Resource'

class Users < Resource
  def initialize(host, username, passwd)
    super host, 'users', username, passwd
  end
end
