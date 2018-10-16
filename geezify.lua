function geezify_2digit(num)
   local oneth_array = {'', '፩', '፪', '፫', '፬', '፭', '፮', '፯', '፰', '፱'}
   local tenth_array = {'', '፲', '፳', '፴', '፵', '፶', '፷', '፸', '፹', '፺'}

   tenth_index = math.floor(num / 10)
   oneth_index = num % 10

   return tenth_array[tenth_index+1] .. oneth_array[oneth_index+1]
end

function geezify_4digit(num)
   first2 = math.floor(num/100)
   second2 = num%100

   if first2==0 then
      return geezify_2digit(second2)
   else
      return geezify_2digit(first2) ..'፻'.. geezify_2digit(second2)
   end
   
   
end

function split_every_4_digit(num)

   local a={}

   table.insert(a, string.sub(num,1, string.len(num)%4))
   
   for digits in string.gmatch(string.sub(num,(string.len(num)%4)+1 ,-1) ,"%d%d%d%d") do
      table.insert(a , digits)
   end

   return a
end


function geezify(num)

   local digarr = split_every_4_digit(num)
   local converted= ""

   for i,v in ipairs(a) do
      if i==1 and v=='' then
	 converted = converted
      else
	 if converted==nil or converted == '' then
	    converted = (conveted or '') .. geezify_4digit(v)
	 else
	    converted = (converted or "") ..'፼'.. geezify_4digit(v)
	 end
      end
   end

  local  geez_no =
     string.gsub(
	string.gsub(
	   string.gsub(converted,'፼፩፻', '፼፻')
	   ,'^፩፼', '፼')
	,'^(፩፻)', '፻')
   return geez_no
end
