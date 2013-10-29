class CategoriesController < AdminController
  require 'json'  
  before_filter :authenticate, :except => [:json]    
  def save
 	
	tree= json_to_tree(params[:json].values)
    
  	tree.each do |v|
  	  if v[:delete]=="true" 
            if v[:new]=="false" 
             c=Categories.find(v[:id])
             if c.respond_to?(:delete)
                 c.delete
             end
            end  
      else
    		if !(@categories=Categories.find(v[:id]))
      	    	@categories=Categories.new
    		end
    		@categories.update_attribute(:id,v[:id] )
      	  	@categories.update_attribute(:name,v[:name] )
  	    	@categories.update_attribute(:pid,v[:pid])
  	    	@categories.update_attribute(:path,v[:path])
        	@categories.save
              
      end
	end
    render text: 'done'
  end

  def json
	  render text: tree_to_json(Categories.where(pid: "null"))
  end
  
  private
  def json_to_tree(obj=self,cid="null",ppath=String.new,h=Array.new)
    obj.each do |a|
      if a.kind_of?(Hash)        
        is_deleted=a['attr'].has_key?('is_deleted')?'true':'false'
        is_new=a['attr'].has_key?('is_new')?'true':'false'
        path=ppath+' / '+a["data"]
        h.push( {:id=>a["attr"]["id"],:name=>a["data"],:pid=>cid,:delete=>is_deleted,:new=>is_new,:path=>ppath+' / '+a["data"] }) 
        if a.has_key?("children")
           c=json_to_tree(a["children"].values,a["attr"]["id"],path)
           h.concat(c)
        end
      end
      path=''
    end
  	return h
  end

  def tree_to_json(obj=self,h={},a=Array.new)
  	obj.each do |v|
    	children=tree_to_json(Categories.where(pid: v.id))
    	h={:data=>v.name,:state=>"open",:attr=>{:id=>v.id},:children=>children.to_json}
    	a<<h
  	end
	  return a.to_json.gsub('\\','').gsub('""','')
  end

end
