class StoresController < ApplicationController
  def index
    @stores = Store.all.page(params[:page])
  end
end
