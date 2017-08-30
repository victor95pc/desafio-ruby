class LoadProductsFromApiJob < ApplicationJob
  LOAD_PRODUCTS_API_FIELDS = {
    name:      'productName',
    image_url: 'items.0.images.0.imageUrl',
    link:      'link',
    price:     'items.0.sellers.0.commertialOffer.Price'
  }

  RECORDS_INTERVAL = 40
  queue_as :default

  def perform(store_id)
    store = Store.find(store_id)

    (store.amount_products_to_load / RECORDS_INTERVAL).ceil.times do |page|
      pagination = "_from=#{page*RECORDS_INTERVAL}&_to=#{(page+1)*RECORDS_INTERVAL}"

      json_array = JSON.parse(HTTP.get("#{website(store)}/api/catalog_system/pub/products/search?#{pagination}").to_s)

      json_array.each do |json|
        fields_api = LOAD_PRODUCTS_API_FIELDS.map{ |field, field_path| [field, get_value_nested_hash(field_path, json)] }
                                             .to_h

        installments = get_value_nested_hash('items.0.sellers.0.commertialOffer.Installments', json)

        fields_api["number_installments"] = installments.map { |i| i["NumberOfInstallments"] }.max
        fields_api["interest_rate"]       = installments.map { |i| i["InterestRate"] }.max

        Product.where(store: store, link: fields_api["link"]).first_or_create do |p|
          p.reindex = false
          p.assign_attributes(fields_api)
        end
      end

      Product.reindex
    end
  end

  private

  def get_value_nested_hash(field, hash)
    field.split('.').reduce(hash) do |value, field|
      value.fetch((value.is_a?(Hash) ? field : field.to_i), {})
    end
  end

  def website(store)
    _website = store.website
    _website.last == '/' ? _website[0..-2] : _website
  end
end
