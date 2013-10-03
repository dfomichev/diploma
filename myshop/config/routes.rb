Myshop::Application.routes.draw do
  get "categories/edit"
  get "categories/save"
  get "categories/show"
  get "products/edit"
  get "products/create"
  post "products/create"
  resources :products do
  	post "save", on: :member
	get "edit", on: :member
  end
  resources :attribute_set do
	post "save",on: :member 
	get "edit", on: :member 
	post "json", on: :member 
  end

end
