Myshop::Application.routes.draw do
  resources "admin", only: [:index]
  get "categories/edit"
  get "categories/save"
  get "categories/show"
  get "products/edit"
  get "products/list"
  get "attributes/list"
  post "products/save"
  get "attributes/edit"
  resources :products do
  	post "save", on: :member
  	post "add_image", on: :member
	get "edit", on: :member
  end
  resources :attributes do
	post "save",on: :member 
	get "edit", on: :member 
	post "json", on: :member 
  end
  post "categories/save"
  get "categories/json"
end
