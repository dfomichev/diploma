require "awesome_print"
a={"utf8"=>".", "authenticity_token"=>"YLqOqEt0fmS2+Owp905PPhaltCbB0iKlEZ3wopbOzV4=", "product"=>{"sku"=>"", "name"=>"", "price"=>""}, "attr_set_id"=>"", "attr_set"=>"Smartfony", "group"=>{"Obshhie harakteristiki"=>{"Standart"=>{"value"=>"", "tag"=>"tag1"}, "Operacionnaja sistema"=>{"value"=>"", "tag"=>"tag2"}, "Ves"=>{"value"=>"", "tag"=>""}}, "Jekran"=>{"Tip jekrana"=>{"value"=>"", "tag"=>""}, "Diagonal'"=>{"value"=>"", "tag"=>""}, "Razreshenie"=>{"value"=>"", "tag"=>""}}}, "controller"=>"products", "action"=>"save"}

product={:sku=> a["product"]["sku"],
         :name=>a["product"]["name"],
         :price=>a["product"]["price"]}

product.merge!(a["group"])
ap product

