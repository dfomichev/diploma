class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:sku,:price,:extra_attributes, :categories, :is_new, :product_id, :images, :p_categories

  def show
   init
   set_data
  end
  
  def edit
   init
  end
    
  def save

    init
    product={:sku=> params["product"]["sku"],
             :name=>params["product"]["name"],
             :price=>params["product"]["price"],
             :categories=>params["cat"].keys }
    del_images(@images-params["images"])
    product.merge!({:extra_attributes=>params["group"],
                    :images=> params["images"] })
    @products.update_attributes(product )
    render text: "Done!" #params["cat"].keys   
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
     render text: "Done!" #file.gsub(/public\//,'')
  end
  
  private 
  def del_images(list=self)
    list.each do |v|
        file=File.join("public",v)
        FileUtils.rm file 
        FileUtils.rm file+'_thumb' 
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
    @product_id=@products.id
    @categories=Categories.all.to_a
    @attributes=Attributes.all.to_a

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
       @images=Array.new
       @p_categories=Array.new 
    end

  end

end
