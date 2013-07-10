require 'libraryh3lp/Resource'

class Presence < Resource
  def initialize(host, username, passwd)
    super host, 'presence/jid', username, passwd
  end

  def check(name, host, format, theme = nil)
    url = theme ? "#{ name }/#{ host }/#{ format }/#{ theme }" : "#{ name }/#{ host }/#{ format }"
    get url
  end
end
