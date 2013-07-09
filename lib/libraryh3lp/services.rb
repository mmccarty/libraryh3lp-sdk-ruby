require 'libraryh3lp/Resource'

class Services < Resource
  def initialize(host, username, passwd)
    super host, 'services', username, passwd
  end

  def listServiceLevels(service_id)
    get_json "#{ service_id }/levels"
  end

  def showServiceLevel(service_id, level_id)
    get_json "#{ service_id }/levels/#{ level_id }"
  end

  def createServiceLevel(service_id, data)
    create data, "#{ service_id }/levels"
  end

  def saveServiceLevel(service_id, level_id, data)
    update service_id, data, "#{ service_id }/levels/#{ level_id }"
  end

  def deleteServiceLevel(service_id, level_id)
    delete_json "#{ service_id }/levels/#{ level_id }"
  end

  def upServiceLevel(service_id, level_id)
    post_json "#{ service_id }/levels/#{ level_id }/up"
  end

  def downServiceLevel(service_id, level_id)
    post_json "#{ service_id }/levels/#{ level_id }/down"
  end

  def listServiceTypes()
    raw_json 'get', 'service-types'
  end
end
