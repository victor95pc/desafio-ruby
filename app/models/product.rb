class Product
  include Mongoid::Document
  attr_accessor :reindex

  field :name, type: String
  field :price, type: Float
  field :number_installments, type: Integer
  field :image_url, type: String
  field :link, type: String
  field :interest_rate, type: Float

  belongs_to :store

  validates_presence_of :name, :image_url, :price, :link

  after_update :reindex_products, if: :name_changed?

  after_create :reindex_products, if: :reindex

  searchkick

  def search_data
    {
      name:     name,
      store_id: store.id.to_s
    }
  end

  rails_admin do
    list do
      field :image_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].image_url, style: 'width:150px' })
        end
      end
      field :name
      field :store
      field :price do
        formatted_value{ |p| bindings[:view].number_to_currency(bindings[:object].price) }
      end
      field :interest_rate do
        formatted_value{ |p| bindings[:view].number_to_percentage(bindings[:object].interest_rate, precision: 0) }
      end
    end

    show do
      field :image_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].image_url, style: 'width:300px' })
        end
      end
      field :name
      field :store
      field :price do
        formatted_value{ |p| bindings[:view].number_to_currency(bindings[:object].price) }
      end
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
      field :image_url, :string
      field :link, :string
    end

    create do
      field :name
      field :price
      field :interest_rate
      field :number_installments
      field :image_url, :string
      field :link, :string
    end
  end

  private

  def reindex_products
    self.class.reindex
  end
end
