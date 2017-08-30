class ProductDecorator < Draper::Decorator
  delegate :price, :name, :image_url, :link

  def price_formated
    h.number_to_currency_br(object.price)
  end

  def installments_info
    if object.number_installments
      "#{object.number_installments}X #{h.number_to_currency_br(object.price / object.number_installments)}"
    end
  end
end
