class Store
  include Mongoid::Document
  field :name, type: String
  field :website, type: String
  field :logo_url, type: String
  field :email, type: String
  field :slug, type: String
  field :amount_products_to_load, type: Integer
  field :on_home_page, type: Boolean, default: false

  has_many :products, dependent: :delete

  validates_uniqueness_of :on_home_page, if: :on_home_page?

  validates_presence_of :website, :name, :logo_url, :email

  after_save :reload_products_from_api, if: -> { amount_products_to_load_changed? || website_changed? }

  before_save :set_slug, if: :name_changed?

  accepts_nested_attributes_for :products

  def self.store_on_home_page
    find_by(on_home_page: true)
  end

  def self.by_store_slug(slug)
    where(slug: slug).first
  end

  rails_admin do
    list do
      field :logo_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].logo_url })
        end
      end

      field :name
      field :on_home_page
      field :email
    end

    show do
      field :logo_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].logo_url })
        end
      end

      field :name
      field :on_home_page
      field :email
      field :amount_products_to_load
      field :on_home_page
      field :website
    end

    edit do
      field :name
      field :on_home_page
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
      field :amount_products_to_load
    end

    create do
      field :name
      field :on_home_page
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
      field :amount_products_to_load
    end
  end

  private

  def reload_products_from_api
    products.delete_all
    LoadProductsFromApiJob.perform_later(id.to_s)
  end

  def set_slug
    self.slug = I18n.transliterate(name).underscore.dasherize
  end
end
