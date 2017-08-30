class ProductsController < ApplicationController
  PER_PAGE = 20

  before_action :check_store_slug_present

  def index
    @products = Product.search(
                  search_value,
                  fields: [:name, :store_id],
                  page: page,
                  per_page: PER_PAGE,
                  where: { store_id: [store_id] }
                )
  end

  private

  def store_id
    Store.by_store_slug(params[:store_slug]).try(:id).try(:to_s)
  end

  def check_store_slug_present
    render_404 if params[:store_slug].blank?
  end

  def page
    params[:page] || '1'
  end

  def search_value
    params['search'].present? ? params['search'] : '*'
  end

  def render_404
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found and return
  end
end
