lua_utf8 = require 'lua-utf8'

arabify = {}

arabify.numhash =  {}
arabify.numhash['፩'] = 1
arabify.numhash['፪'] = 2
arabify.numhash['፫'] = 3
arabify.numhash['፬'] = 4
arabify.numhash['፭'] = 5
arabify.numhash['፮'] = 6
arabify.numhash['፯'] = 7
arabify.numhash['፰'] = 8
arabify.numhash['፱'] = 9
arabify.numhash['፲'] = 10
arabify.numhash['፳'] = 20
arabify.numhash['፴'] = 30
arabify.numhash['፵'] = 40
arabify.numhash['፶'] = 50
arabify.numhash['፷'] = 60
arabify.numhash['፸'] = 70
arabify.numhash['፹'] = 80
arabify.numhash['፺'] = 90
arabify.numhash[' '] = 0


function arabify.arabify(str)
   local splitted = arabify.split('፼',arabify.rollback(str))
   local sum = 0
   for i,v in ipairs(splitted) do
      if v=='' then
	 sum = sum + (0* 10000^(#splitted - i))
      else
	 sum = sum + (arabify.convert_upto10000(v)* 10000^(#splitted - i))
      end
   end
   return math.floor(sum)
end

function arabify.rollback(str)
   return  lua_utf8.gsub(lua_utf8.gsub(lua_utf8.gsub(str,'^፼', '፩፼'),'^፻', '፩፻'),'፼፻', '፼፩፻')
end

function arabify.split_by_10000s(str)
   return arabify.split(string.gsub(str,'፼$', '፼ '), '፼')
end


function arabify.convert_2digit(str)
   return (arabify.numhash[lua_utf8.sub(str,1,1)] or 0) + (arabify.numhash[lua_utf8.sub(str,2,2)] or 0)
end


function arabify.convert_upto10000(str)
   if type(str) == 'string' and utf8.len(str) <= 5 and nil == lua_utf8.match(str, '፼') then
      local pos_of_100 = lua_utf8.find(str, '፻') or 0

      if pos_of_100 == 0 then
      	 return  arabify.convert_2digit(str)
      elseif pos_of_100 == 1 then
	 return 100 + arabify.convert_2digit(lua_utf8.sub(str, pos_of_100+1, lua_utf8.len(str))) or 0
      else
      	 return (arabify.convert_2digit(lua_utf8.sub(str, 1, pos_of_100-1)) or 1) * 100 + (arabify.convert_2digit(lua_utf8.sub(str, pos_of_100+1, lua_utf8.len(str))) or 0)
      end      
   end
end

function arabify.split(delimiter, text)
   local list = {}
   local pos = 1
   if lua_utf8.find("", delimiter, 1) then
      error("delimiter matches empty string!")
   end                                            
   while 1 do
      local first, last = lua_utf8.find(text, delimiter, pos)
      if first then 
         table.insert(list, lua_utf8.sub(text, pos, first-1))
         pos = last+1
      else
         table.insert(list, lua_utf8.sub(text, pos))
         break
      end
   end
   return list
end


return arabify
