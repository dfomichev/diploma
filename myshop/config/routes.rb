Myshop::Application.routes.draw do
  resources "admin", only: [:index]
  get "admin/logout"
  get "categories/edit"
  get "categories/save"
  get "categories/show"
  get "products/edit"
  get "products/list"
  get "attributes/list"
  post "products/save"
  get "attributes/edit"
  get "front/index"  
  resources :front do
    get "show", on: :member
  end
  resources :products do
  	post "save", on: :member
  	post "add_image", on: :member
  	get "delete", on: :member
	get "edit", on: :member
  end
  resources :attributes do
	post "save",on: :member 
	get "edit", on: :member 
	get "delete", on: :member 
	post "json", on: :member 
  end
  post "categories/save"
  get "categories/json"
end
