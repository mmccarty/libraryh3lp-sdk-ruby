require "libraryh3lp/Resource"
require "json"

class Chats < Resource

  def initialize (host, username, passwd)
    super host, "/conversations", username, passwd
  end

  def listDay (year, month, day, to = nil, format = 'json')
    dt = DateTime.new(year, month, day).strftime("%Y/%m/%d")
    params = {'format' => format}
    if to then
      params['to'] = to
    end
    response = @site[@baseurl + "/#{dt}"].get(:params => params)
    return [JSON.parse(response.to_str), response.code]
  end

  def listMonth (year, month, to = nil)
    dt = DateTime.new(year, month, 1).strftime("%Y/%m")
    params = {}
    if to then
      params['to'] = to
    end
    response = @site[@baseurl + "/#{dt}"].get(:params => params)
    return [JSON.parse(response.to_str), response.code]
  end

  def listYear (year, to = nil)
    params = {}
    if to then
      params['to'] = to
    end
    response = @site[@baseurl + "/#{year}"].get(:params => params)
    return [JSON.parse(response.to_str), response.code]
  end

  def anonymizeChats (ids, to = nil)
    params = {"ids" => ids.join(',')}
    response = @site[@baseurl + "/anonymize-conversations"].post params, :content_type => :plain
    return [JSON.parse(response.to_str), response.code]
  end

  def deleteChats (ids, to = nil)
    params = {"ids" => ids.join(',')}
    response = @site[@baseurl + "/delete-conversations"].post params, :content_type => :plain
    return [JSON.parse(response.to_str), response.code]
  end

  def deleteTranscripts (ids, to = nil)
    params = {"ids" => ids.join(',')}
    response = @site[@baseurl + "/delete-transcripts"].post params, :content_type => :plain
    return [JSON.parse(response.to_str), response.code]
  end

  def archiveConversations (ids, to = nil)
    response = @site[@baseurl + "/archive"].get({:params => {"ids" => ids.join(',')}, :content_type => :plain})
    return [response, response.code]
  end
end
