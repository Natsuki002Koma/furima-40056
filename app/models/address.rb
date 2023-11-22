class Address < ApplicationRecord
  belongs_to :prefecture

  validates :post_code, :city, :street, :tel, presence: true
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
end
