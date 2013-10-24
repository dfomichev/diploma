class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:sku,:price,:extra_attributes, :categories, :is_new, :product_id, :images, :p_categories, :currency
  before_filter :authenticate, :except =>[:list,:show]

  def show
   init
   set_data
  end
  
  def edit
   init
   render "edit"
  end
  
  def list
    @currency=get_currency  
    @list=Products.all.to_a  
  end
    
  def save

    init
    product={:sku=> params["product"]["sku"],
             :name=>params["product"]["name"],
             :price=>params["product"]["price"]
            }
    if params["cat"].respond_to?(:keys)
        product.merge!({:categories=>params["cat"].keys })
    end
    if params.has_key?("images") && @images.respond_to?(:each)
        del_images(@images-params["images"])
    else 
        del_images(@images)
    end
    product.merge!({:extra_attributes=>params["group"],
                    :images=> params["images"] })
    @products.update_attributes(product )
    render text: "<small>Product saved.  ID: "+@products.id+"</small>" 
  end

  def add_image
     tmp = params[:file_upload][:image].tempfile
     require 'fileutils'
     of=params[:file_upload][:image].original_filename
     df=SecureRandom.hex
     file = File.join("public/images", df[0] ,df)
     FileUtils.mkdir_p File.dirname(file)
     FileUtils.cp tmp.path, file
     Thumbnails.new(file)
     render text: file.gsub(/public\//,'')
  end
  def delete
    p=Products.find(params['id'])
    if p.respond_to?(:destroy);
        p.destroy
    end    
    render text: 'Done!'
  end    
  
  private 
  def del_images(list=self)
    if list.respond_to?(:each)
        list.each do |v|
            file=File.join("public",v)
            if File.exists?(file)
               FileUtils.rm file 
               FileUtils.rm file+'_thumb' 
            end
        end 
    end
  end   
  def get_currency
      return 'P'  
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
    @product_id=@products.id
    @categories=Categories.all.to_a
    @attributes=Attributes.all.to_a
    @images=Array.new
    @p_categories=Array.new
    if @products.respond_to?:name
      @name=@products.name
      @sku=@products.sku
      @price=@products.price
      @extra_attributes=@products.extra_attributes
      @images=@products.images
      @p_categories=@products.categories
    else
       @name=String.new
       @sku=String.new
       @price=String.new
       @extra_attributes={}
    end

  end

end
