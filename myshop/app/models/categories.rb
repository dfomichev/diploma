class Categories
  include Mongoid::Document
  field :name, type: String
  field :pid, type: String
  field :id, type: String
#  attr_readonly :id
end
