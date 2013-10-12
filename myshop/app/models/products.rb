class Products
  include Mongoid::Document
  field :sku,type: String
  field :name,type: String
  field :price,type: String
  field :categories,type: Array
  field :extra_attributes,type: Hash
  field :images,type: Array
end

