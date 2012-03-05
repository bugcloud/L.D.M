module ApplicationHelper
  def f(str)
    str.force_encoding('utf-8')
  end

  def facebook_image(id)
    "https://graph.facebook.com/#{id}/picture"
  end

  def hbr(str)
    h(str).gsub(/\r\n|\r|\n/, "<br />\n")
  end
end
