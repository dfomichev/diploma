class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:sku,:price,:extra_attributes, :categories, :is_new, :product_id

  def show
   init
   set_data
  end
  
  def edit
   init
  end
    
  def save
    product={:sku=> params["product"]["sku"],
             :name=>params["product"]["name"],
             :price=>params["product"]["price"]}

    product.merge!({:extra_attributes=>params["group"]})
    init
    @products.update_attributes(product )
    @products.save
    render text: @products.id 
  end

  def add_image
     tmp = params[:file_upload][:image].tempfile
     require 'fileutils'
     of=params[:file_upload][:image].original_filename
     file = File.join("public/images", of[0] ,of)
     FileUtils.mkdir_p File.dirname(file)
     FileUtils.cp tmp.path, file
     render text: File.dirname(file)
  end
  
  private 


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
    @product_id=@products.id
    @categories=Categories.all.to_a
    @attributes=Attributes.all.to_a

    if @products.respond_to?:name
      @name=@products.name
      @sku=@products.sku
      @price=@products.price
      @extra_attributes=@products.extra_attributes
    else
       @name=String.new
       @sku=String.new
       @price=String.new
       @extra_attributes={}
    end

  end

end
