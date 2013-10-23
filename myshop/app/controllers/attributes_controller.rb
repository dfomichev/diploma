class AttributesController < ApplicationController
  require 'securerandom'
  attr_accessor :attributes,:name,:list,:is_new

  
  def edit
   init
   set_data
  end

  def list
    @list=Attributes.all.to_a
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
      list={}
      params[:param][k].sort_by{|x,y|y[:order]} .each do |a,b|    
         list[b[:name]]={}
         list[b[:name]]['type']=b['type']
      end
      attr_set[:list][v[:name]]['attributes']=list
    end
    @attributes.update_attribute(:name,attr_set[:name] )
    @attributes.update_attribute(:list,attr_set[:list])
    @attributes.save
     		
    render text: 'done!'
  end

  def json
    init
    set_data
    render text: @list.to_json
  end

  def delete
    p=Attributes.find(params['id'])
    if p.respond_to?(:destroy);
        p.destroy
    end
    render text: 'Done!'
  end

  
  private 

  def set_data
   @name=@attributes.name	
   @list=@attributes.list
   @attribute_types=['string','text','url']
  end

  def init
    @is_new=false
    if params.has_key?('id')
      @attributes=Attributes.find(params['id'])
    else
      @attributes=nil
    end	
    if !attributes
      @attributes=Attributes.new
      @is_new=true
    end
    @group_id=attributes.id
  end

end