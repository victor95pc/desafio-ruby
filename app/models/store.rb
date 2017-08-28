class Store
  include Mongoid::Document
  field :name, type: String
  field :website, type: String
  field :logo_url, type: String
  field :email, type: String
  field :on_home_page, type: Boolean, default: false

  has_many :products, dependent: :destroy

  validates_uniqueness_of :on_home_page, if: :on_home_page?

  accepts_nested_attributes_for :products

  def self.store_on_home_page
    find_by(on_home_page: true)
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
      field :on_home_page
      field :website
    end

    edit do
      field :name
      field :on_home_page
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
    end

    create do
      field :name
      field :on_home_page
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
    end
  end
end
