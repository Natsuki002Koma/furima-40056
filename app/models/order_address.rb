class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street, :building, :tel, :item_id, :user_id ,:token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :validate_tel_number
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, building: building, tel: tel, order_id: order.id)
  end
  
  private

    def validate_tel_number
      if tel.blank?
        errors.add(:tel, "can't be blank")
      end
      if tel.length < 10
        errors.add(:tel, "is too short")
      end
      if !tel.match?(/\A[0-9]{10,11}\z/)
        errors.add(:tel, "is invalid. Input only number")
      end
    end
  end