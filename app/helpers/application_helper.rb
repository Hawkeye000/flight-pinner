module ApplicationHelper
  def login_logout_links
    if user_signed_in?
      render 'layouts/logged_in_nav'
    else
      render 'layouts/logged_out_nav'
    end
  end
end
