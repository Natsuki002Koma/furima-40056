class Item < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :item_name, :description, :price, presence: true
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 } 

end
