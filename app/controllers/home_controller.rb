class HomeController < ApplicationController
  def index
    slug = Store.try(:store_on_home_page).try(:slug)

    if slug
      redirect_to products_path(slug)
    else
      redirect_to stores_path
    end
  end
end
