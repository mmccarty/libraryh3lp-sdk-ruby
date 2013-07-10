require 'libraryh3lp/Resource'

class Widgets < Resource
  def initialize(host, username, passwd)
    super host, 'widgets', username, passwd
  end
end
