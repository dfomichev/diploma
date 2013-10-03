Myshop::Application.routes.draw do
#  get "attribute_set/save"
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
  end

end
