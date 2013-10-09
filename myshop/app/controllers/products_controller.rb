class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:sku,:price,:extra_attributes, :categories, :is_new

  def show
   init
   set_data
  end
  
  def edit
   init
   set_data
   @attribute_types=['video','text','number','file']
  end
    
  def save
    product={:sku=> params["product"]["sku"],
             :name=>params["product"]["name"],
             :price=>params["product"]["price"]}

    product.merge!({:extra_attributes=>params["group"]})
    init
    @products.update_attributes(product )
    @products.save
     		
    set_data
    render text: @products.id 
  end
  
  private 

  def set_data
    @categories=Categories.all.to_a
    @attributes=Attributes.all.to_a
    if @products.respond_to?:name
      @name=@products.name
      @sku=@products.sku
      @price=@products.price
      @extra_attributes=@products.extra_attributes
    else
       @name=''
       @sku=''
       @price=''
       @extra_attributes={}
    end
  end

  def init
    if params.has_key?('id')
      @products=Products.find(params['id'])
      @is_new=false
    else
      @products=nil
    end	
    if !@products

      @products=Products.new
      @is_new=true
      
    end
    @group_id=@products.id
  end

end
