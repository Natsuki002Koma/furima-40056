class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  validates :nickname, presence: true
  validates :date_of_birth, presence: true

  with_options presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i, message: '半角英数字（混合）を使用してください' } do
    validates :password
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角（漢字・ひらがな・カタカナ）を使用してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角（カタカナ）を使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
