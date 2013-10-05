class Categories
  include Mongoid::Document
  field :name, type: String
  field :pid, type: String
  field :path, type: String
  field :id, type: String
  index({ path: 1 })
end

