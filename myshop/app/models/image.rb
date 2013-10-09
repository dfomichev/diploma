class Image
  include Mongoid::Document
  field :data, type: BSON::Binary
  field :product_id, type: String
end
