class Store
  include Mongoid::Document
  field :name, type: String
  field :website, type: String
  field :logo_url, type: String
  field :email, type: String

  has_many :products, dependent: :destroy

  accepts_nested_attributes_for :products

  rails_admin do
    list do
      field :logo_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].logo_url })
        end
      end

      field :name
      field :email
    end

    show do
      field :logo_url do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].logo_url })
        end
      end

      field :name
      field :email
      field :website
    end

    edit do
      field :name
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
    end

    create do
      field :name
      field :logo_url, :string
      field :email,    :string
      field :website,  :string
    end
  end
end
