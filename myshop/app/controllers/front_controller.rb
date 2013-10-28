class FrontController < ApplicationController
 def index
  @categories=cat_tree(Categories.where(pid: "null")) ;
#  render text: @categories   
 end   
 def children
  @path=Categories.find( params[:id]).path
  @children=Categories.where(pid: params[:id])
 end 

 def products
  @currency=CURRENCY
  @products=Products.where(categories: params[:id])
 end 
 def show
 if params.has_key?('id')
     @products=Products.find(params['id'])
     if !@products.nil?
        render "show"
     else
        render text: 'No such product'
     end
     
 else
     render text: 'Error'
 end
 end

  def cat_tree(obj=self,h={},a=Array.new)
    obj.each do |v|
        children=cat_tree(Categories.where(pid: v.id))
        h={:name=>v.name,:id=>v.id,:children=>children}
        a<<h
    end
      return a
  end


end
