class CategoriesController < ApplicationController

  def save
 	
	tree= json_to_tree(params[:json].values)
  	tree.each do |v|
  		if v[:delete]=="true" 
        if v[:new]=="false" 
          Categories.find(v[:id]).delete
        end  
      else
    		if !(@categories=Categories.find(v[:id]))
      		@categories=Categories.new
    		end
    		@categories.update_attribute(:id,v[:id] )
  	  	@categories.update_attribute(:name,v[:name] )
  		  @categories.update_attribute(:pid,v[:pid])
    	  @categories.save
      end
	  end
    render text: 'done'
  end

  def show

  end
  def json
	  render text: tree_to_json(Categories.where(pid: "null"))
  end
  
  private
  def json_to_tree(obj=self,cid="null",h=Array.new)
    obj.each do |a|
      if a.kind_of?(Hash)        
        is_deleted=a['attr'].has_key?('is_deleted')?'true':'false'
        is_new=a['attr'].has_key?('is_new')?'true':'false'
        h.push( {:id=>a["attr"]["_cid"],:name=>a["data"],:pid=>cid,:delete=>is_deleted,:new=>is_new})
        if a.has_key?("children")
           c=json_to_tree(a["children"].values,a["attr"]["_cid"])
           h.concat(c)
        end
      end
    end
  	return h
  end
  
  def tree_to_json(obj=self,h={},a=Array.new)
  	obj.each do |v|
    	children=tree_to_json(Categories.where(pid: v.id))
    	h={:data=>v.name,:state=>"open",:attr=>{:_cid=>v.id},:children=>children.to_json}
    	a<<h
  	end
	  return a.to_json.gsub('\\','').gsub('""','')
  end

end
