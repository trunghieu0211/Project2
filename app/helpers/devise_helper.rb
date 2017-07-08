module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    messages = resource.errors.full_messages.map{|message| content_tag(:li, message)}.join
    html = <<-HTML
      <div class="alert alert-error alert-danger dialog">
        #{messages}
      </div>
    HTML
    html.html_safe
  end

  def picture_for user
    if user.avatar?
      image_tag user.avatar_url()
    else
      image_tag "default.png.jpg"
    end
  end
end
