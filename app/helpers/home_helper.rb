module HomeHelper
  def current_store_logo
    Store.by_store_slug(params[:store_slug]).try(:logo_url)
  end
end
