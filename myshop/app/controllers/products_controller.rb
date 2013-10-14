class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:list, :categories

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
    init	

    sku=params[:product][:sku]    
    name=params[:product][:name]
    price=params[:product][:price]

    params[:group].each do |k,v|
      list={}
      params[:group][k].each do |a,b|    
      end
    end
    render text: params[:group].inspect
    
 #   @products.update_attribute(:name,product[:name] )
 #   @products.update_attribute(:list,product[:list])
 #    @products.save
     		
    set_data
  #  render "show"
  end
  
  private 

  def set_data
    @name=''
    @list={}
    @categories=Categories.all.to_a
    @attributes=Attributes.all.to_a
    if @products.respond_to?:name
      @name=@products.name	
      @list=@products.list
    end
  end

  def init
    if params.has_key?('id')
      @products=Products.find(params['id'])
    else
      @products=nil
    end	
    if !products

      @products=Products.new
      
    end
    @group_id=products.id
  end

end
