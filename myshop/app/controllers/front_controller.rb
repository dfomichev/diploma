class FrontController < ApplicationController

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

end
