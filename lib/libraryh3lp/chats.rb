require 'libraryh3lp/Resource'

class Chats < Resource
  def initialize(host, username, passwd)
    super host, 'conversations', username, passwd
  end

  def listDay(year, month, day, to = nil, format = 'json')
    dt = DateTime.new(year, month, day).strftime '%Y/%m/%d'
    get_json dt, params: opt_params(format: format, to: to)
  end

  def listMonth(year, month, to = nil)
    dt = DateTime.new(year, month, 1).strftime '%Y/%m'
    get_json dt, params: opt_params(to: to)
  end

  def listYear(year, to = nil)
    get_json year, params: opt_params(to: to)
  end

  def anonymizeChats(ids, to = nil)
    post_json 'anonymize-conversations', { ids: ids.join(',') }, content_type: :plain
  end

  def deleteChats(ids, to = nil)
    post_json 'delete-conversations', { ids: ids.join(',') }, content_type: :plain
  end

  def deleteTranscripts(ids, to = nil)
    post_json 'delete-transcripts', { ids: ids.join(',') }, content_type: :plain
  end

  def archiveConversations(ids, to = nil)
    get 'archive', params: { ids: ids.join(',') }, content_type: :plain
  end
end
