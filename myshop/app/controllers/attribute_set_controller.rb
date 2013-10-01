class AttributeSetController < ApplicationController
  require 'securerandom'
  def show
    @group_id='6453af5464616e28b3120000'
    @attribute_types=["text","number","category"]
    attributes=Attributes.find(params[:group_id])
    @name=attributes.read_attribute(:name)
    @list=attributes.read_attribute(:list)
  end
  
  def edit
    @group_id='6453af5464616e28b3120000'
    @attribute_types=["text","number","category"]
    @categories=["default"]
    @page_title='Test'    
  #  attributes=Attributes.find(@group_id)
#    @name=attributes.read_attribute(:name)
 #   @list=attributes.read_attribute(:list)    
  end

  def save

    attr_set={}
    attr_set[:name]=params[:name]
    attr_set[:list]={}
    params[:group].each do |k,v|
      attr_set[:list][v[:name]]={}
      attr_set[:list][v[:name]][:id]=SecureRandom.hex
      attr_set[:list][v[:name]][:order]=v[:order]
      list={}
      params[:param][k].each do |a,b|    
         list[b[:name]]={}
         list[b[:name]][:type]=b[:type]
         list[b[:name]][:order]=b[:order]
      end
      attr_set[:list][v[:name]][:attributes]=list

      
    end
    
    if params.has_key?(:attr_set_id)
      attributes=Attributes.find("params[:attr_set_id]")
    else
      attributes=nil
    end  
    
    if !attributes
      attributes=Attributes.new
      @group_id=attributes.id
    
    end
      attributes.update_attribute(:name,attr_set[:name] )
      attributes.update_attribute(:list,attr_set[:list])
      attributes.save
    self.show
  end
end
