class User
  include Mongoid::Document
  include Mongoid::Enum
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum :profile, [ :admin, :store_owner ],  default: nil

  validates_presence_of :profile, :email

  def profile_enum
    User::PROFILE
  end

  rails_admin do
    list do
      field :email
      field :profile, :enum
      field :last_sign_in_at
    end

    show do
      field :email
      field :profile, :enum
      field :last_sign_in_at
    end

    edit do
      field :email, :string
      field :profile, :enum do
        visible do
          bindings[:view]._current_user.admin?
        end
      end
      field :password
      field :password_confirmation
    end

    create do
      field :email, :string
      field :profile, :enum do
        visible do
          bindings[:view]._current_user.admin?
        end
      end
      field :password
      field :password_confirmation
    end
  end

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
