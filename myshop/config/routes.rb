Myshop::Application.routes.draw do
  get "attribute_set/show"
  get "attribute_set/edit"
  get "attribute_set/save"
  post "attribute_set/save"
  get "products/new"
  get "products/create"
  post "products/create"
  resources :products
end
