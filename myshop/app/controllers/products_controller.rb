class ProductsController < ApplicationController
  def new
  @product=Product.new       
  @attribute_types=["text","number","category"]
  @categories=["default"]
  @page_title='Test'
  end

  def create
  	render text: params.inspect
  end
end
