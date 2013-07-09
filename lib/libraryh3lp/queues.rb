require 'libraryh3lp/Resource'

class Queues < Resource
  def initialize(host, username, passwd)
    super host, 'queues', username, passwd
  end

  %w(operator gateway).each do |name|
    title = name.split(/(\W)/).map(&:capitalize).join

    define_method "list#{ title }s" do |id|
      get_json "#{ id }/#{ name }s"
    end

    define_method "create#{ title }" do |id, data|
      create data, "#{ id }/#{ name }s"
    end

    define_method "destroy#{ title }" do |id, item_id|
      delete_json "#{ id}/#{ name }s/#{ item_id}"
    end
  end

  def updateOperator(queue_id, operator_id, data)
    update queue_id, data, "#{ queue_id }/operators/#{ operator_id }"
  end

  def showProfile(queue_id)
    get "#{ queue_id }/profiles/staff"
  end

  def updateProfile(queue_id, profile)
    put_json "#{ queue_id }/profiles/staff", profile, content_type: :plain
  end
end
