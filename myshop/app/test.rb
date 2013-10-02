a={"attr1"=>[[:order, "40"], [:type, "text"]], "attr2"=>[[:order, "20"], [:type, "video"]]}
a=a.sort_by do |k,v| v[0][2]
     puts "#{v[0][1]} -- #{k}"
end

