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
    Store.by_store_slug(params[:store_slug]).try(:id).try(:to_s) || store_not_found
  end

  def check_store_slug_present
    store_not_found if params[:store_slug].blank?
  end

  def page
    params[:page] || '1'
  end

  def search_value
    params['search'].present? ? params['search'] : '*'
  end

  def store_not_found
    redirect_to(stores_path, alert: 'Loja não encontrada') and return
  end
end
