module ApplicationHelper

  def login_logout_links
    if user_signed_in?
      render 'layouts/logged_in_nav'
    else
      render 'layouts/logged_out_nav'
    end
  end

  def sortable(column, title=nil)
    direction = (column.to_s == sort_column.to_s && sort_direction == "asc") ? "desc" : "asc"
    title ||= column
    if (sort_column.to_s == column.to_s)
      title += direction == "asc" ? "\u25b2" : "\u25bc"
    end
    link_to title, { sort:column, direction:direction }, { id:"sort-by-#{column}" }
  end
  
end
