Myshop::Application.routes.draw do
#  get "attribute_set/:id"
#  get "attribute_set/:id/edit"
#  get "attribute_set/save"
  post "attribute_set/save"
  get "products/new"
  get "products/create"
  post "products/create"
  resources :products
  resources :attribute_set
end
