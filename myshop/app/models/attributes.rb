class Attributes
  include Mongoid::Document
  field :name, type: String
  field :list, type: Hash 
  attr_readonly :id
end

