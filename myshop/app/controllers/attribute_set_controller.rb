class AttributeSetController < ApplicationController
  require 'securerandom'
  attr_accessor :attributes,:name,:list

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
      attr_set[:list][v[:name]][:tag]=v[:tag]
      list={}
      params[:param][k].sort_by{|x,y|y[:order]} .each do |a,b|    
         list[b[:name]]={}
         list[b[:name]][:type]=b[:type]
         list[b[:name]][:tag]=b[:tag]
      end
      attr_set[:list][v[:name]][:attributes]=list
    end
    @attributes.update_attribute(:name,attr_set[:name] )
    @attributes.update_attribute(:list,attr_set[:list])
    @attributes.save
     		
    set_data
    render :show
  end
  
  private 

  def set_data
   @name=@attributes.name	
   @list=@attributes.list
  end

  def init
    if params.has_key?('id')
      @attributes=Attributes.find(params['id'])
    else
      @attributes=nil
    end	
    if !attributes
      @attributes=Attributes.new
    end
    @group_id=attributes.id
  end

end
