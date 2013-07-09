require 'libraryh3lp/Resource'

class Queues < Resource
  def initialize(host, username, passwd)
    super host, 'queues', username, passwd
  end

  def listOperators(queue_id)
    get_json "#{ queue_id }/operators"
  end

  def createOperator(queue_id, data)
    create data, "#{ queue_id }/operators"
  end

  def updateOperator(queue_id, operator_id, data)
    update queue_id, data, "#{ queue_id }/operators/#{ operator_id }"
  end

  def destroyOperator(queue_id, operator_id)
    delete_json "#{ queue_id}/operators/#{ operator_id}"
  end

  def listGateways(queue_id)
    get_json "#{ queue_id }/gateways"
  end

  def createGateway(queue_id, data)
    create data, "#{ queue_id }/gateways"
  end

  def destroyGateway(queue_id, gateway_id)
    delete_json "#{ queue_id}/gateways/#{ gateway_id}"
  end

  def showProfile(queue_id)
    get "#{ queue_id }/profiles/staff"
  end

  def updateProfile(queue_id, profile)
    put_json "#{ queue_id }/profiles/staff", profile, content_type: :plain
  end
end
