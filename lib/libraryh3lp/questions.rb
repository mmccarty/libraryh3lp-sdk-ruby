require 'libraryh3lp/Resource'

class Questions < Resource
  def initialize(host, username, passwd)
    super host, 'ask/questions', username, passwd
  end

  def showAnswer(id)
    get_json "#{ id }/answer"
  end

  def saveAnswer(id, answer)
    put_json "#{ id }/answer", answer, content_type: :plain
  end

  def resetLikes(id)
    delete_json "#{ id }/likes"
  end

  def resetDislikes(id)
    delete_json "#{ id }/dislikes"
  end

  def resetViews(id)
    delete_json "#{ id }/views"
  end

  def addTopic(id, topic)
    post_json "#{ id }/topics", JSON.dump({topic: topic}), content_type: :json, accept: :json
  end
end
