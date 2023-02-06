class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  validates :nickname, presence: true
  
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: "must be a mixture of single-byte alphanumeric characters"
  
  LASTNAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]/.freeze
  validates :last_name, presence: true
  validates_format_of :last_name, with: LASTNAME_REGEX, message: "must be entered in full-width characters"

  FIRSTNAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze

  validates :first_name, presence: true
  validates_format_of :first_name, with: FIRSTNAME_REGEX, message: "must be entered in full-width characters"

  LASTNAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :last_name_kana, presence: true
  validates_format_of :last_name_kana, with: LASTNAME_KANA_REGEX, message: "must be entered in full-width characters"

  FIRSTNAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :first_name_kana, presence: true
  validates_format_of :first_name_kana, with: FIRSTNAME_KANA_REGEX, message: "must be entered in full-width characters"

  validates :birthday, presence: true
end
