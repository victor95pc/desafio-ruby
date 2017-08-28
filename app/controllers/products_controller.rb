class ProductsController < ApplicationController
  has_scope :by_store_slug, as: :store_slug

  def index
    @products = find_products
  end

  private

  def find_products
    slug = params[:store_slug]

    if slug
      Store.by_store_slug(slug) || render_404
    else
      Product.all
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found and return
  end
end
