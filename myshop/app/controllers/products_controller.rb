class ProductsController < ApplicationController
  require 'securerandom'
  attr_accessor :products,:name,:list

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
    attr_set={}
    attr_set[:name]=params[:name]
    attr_set[:name]=params[:name]
    attr_set[:list]={}

    params[:group].sort_by{|x,y|y[:order]}.each do |k,v|
      attr_set[:list][v[:name]]={}
      attr_set[:list][v[:name]][:id]=SecureRandom.hex
      attr_set[:list][v[:name]]['tag']=v['tag']
      list={}
      params[:param][k].sort_by{|x,y|y[:order]} .each do |a,b|    
         list[b[:name]]={}
         list[b[:name]]['type']=b['type']
         list[b[:name]]['tag']=b['tag']
      end
      attr_set[:list][v[:name]]['products']=list
    end
    @products.update_attribute(:name,attr_set[:name] )
    @products.update_attribute(:list,attr_set[:list])
    @products.save
     		
    set_data
    render "show"
  end
  
  private 

  def set_data
    @name=''
    @list={}
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
