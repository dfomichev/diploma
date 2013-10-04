class CategoriesController < ApplicationController
  def edit
  end

  def save
	a=''
 	tree= get_tree(params[:json].values)
	tree.each do |v|
		@categories=Categories.new
		@categories.update_attribute(:id,v[:id] )
		@categories.update_attribute(:name,v[:name] )
		@categories.update_attribute(:pid,v[:pid])
		@categories.save
	end	

  end

  def show
  end
  private
  def get_tree(obj=self,cid="null",h=Array.new)
        obj.each do |a|
                if a.kind_of?(Hash)
                is_deleted=a["attr"].has_key?("is_deleted")?"true":"false"
                is_new=a["attr"].has_key?("is_new")?"true":"false"
                h.push( {:id=>a["attr"]["_cid"],:name=>a["data"],:pid=>cid,:delete=>is_deleted,:new=>is_new})
                 if a.has_key?("children")
                        c=get_tree(a["children"].values,a["attr"]["_cid"])
                        h.concat(c)
                 end
                end
        end
  	return h
  end

end
