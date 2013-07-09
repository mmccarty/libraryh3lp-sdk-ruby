require 'libraryh3lp/Resource'

class Reports < Resource
  def initialize(host, username, passwd)
    super host, 'reports', username, passwd
  end

  %w(hour month protocol queue operator).each do |report|
    title = report.split(/(\W)/).map(&:capitalize).join
    define_method "chatsPer#{ title }" do |params|
      get "chats-per-#{ report }", params: default_params(params)
    end
  end

  def default_params(params)
    %w(sysmsg notanswered).each do |name|
      if ! params.has_key?(name) then
        params[name] = false
      end
    end
    if params['format'] != 'cvs' then
      params.delete('format')
    end
    opt_params(params)
  end
end
