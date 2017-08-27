class Product
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  field :number_installments, type: Integer
  field :image, type: String
  field :link, type: String
  field :interest_rate, type: Float
  field :amount, type: Integer

  belongs_to :store

  mount_uploader :image, ProductImageUploader

  validates_presence_of :name, :image, :price, :number_installments, :amount, :interest_rate

  rails_admin do
    list do
      field :image
      field :name
      field :store
      field :price do
        formatted_value{ |p| bindings[:view].number_to_currency(bindings[:object].price) }
      end
      field :amount
      field :interest_rate do
        formatted_value{ |p| bindings[:view].number_to_percentage(bindings[:object].interest_rate, precision: 0) }
      end
    end

    show do
      field :image do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].image.url })
        end
      end
      field :name
      field :store
      field :price do
        formatted_value{ |p| bindings[:view].number_to_currency(bindings[:object].price) }
      end
      field :amount
      field :interest_rate do
        formatted_value{ |p| bindings[:view].number_to_percentage(bindings[:object].interest_rate, precision: 0) }
      end
    end

    edit do
      field :name
      field :price
      field :interest_rate
      field :number_installments
      field :store
      field :amount
      field :image
      field :link, :string
    end

    create do
      field :name
      field :price
      field :interest_rate
      field :number_installments
      field :amount
      field :image
      field :link, :string
    end
  end
end
