require 'libraryh3lp/Resource'

class Calls < Resource
  def initialize(host, username, passwd)
    super host, 'queues', username, passwd
  end

  def emailTranscript(queue_name, guest_jid, chat_id, email)
    post_json("#{ queue_name }/calls/#{ guest_jid }/#{ chat_id }/mail",
              JSON.dump({email: email}),
              content_type: :json,
              accept: :json)
  end

  def sendFile(queue_name, guest_jid, chat_id, filepath)
    post_json "#{ queue_name }/calls/#{ guest_jid }/#{ chat_id }/file", file: File.new(filepath, 'rb')
  end

  def listTransferTargets(queue_name, guest_jid, chat_id)
    get_json "#{ queue_name }/calls/#{ guest_jid }/#{ chat_id }/transfer"
  end

  def transfer(queue_name, guest_jid, chat_id, target)
    post_json("#{ queue_name }/calls/#{ guest_jid }/#{ chat_id }/transfer",
              JSON.dump({target: target}),
              content_type: :json,
              accept: :json)
  end

  def viewTranscript(queue_name, guest_jid, chat_id)
    get "#{ queue_name }/calls/#{ guest_jid }/#{ chat_id }"
  end
end
