class HomeController < ApplicationController
  def index
    slug = Store.store_on_home_page.slug

    redirect_to products_path(slug)
  end
end
