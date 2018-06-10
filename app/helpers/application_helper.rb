module ApplicationHelper
  def slugged_url(slug)
    "#{request.protocol}#{request.host_with_port}/#{slug}"
  end
end
