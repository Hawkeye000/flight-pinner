module ApplicationHelper
  def login_logout_links
    if user_signed_in?
      render 'layouts/logged_in_dropdown'
    else
      link_to('Login', new_user_session_path)
    end
  end
end
