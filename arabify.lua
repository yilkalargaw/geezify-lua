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




function arabify.split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
	if sep=='' then
	   for _, c in utf8.codes(inputstr) do
	      table.insert(t, utf8.char(c))
	   end
	else
	   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
	      t[i] = str
	      i = i + 1
	   end
	end
	return t
end

function arabify.split_by_10000s(str)
   return arabify.split(string.gsub(str,'፼$', '፼ '), '፼')
end

function arabify.convert_each_2_digit(arr)
   local converted_arr={}
   for _,v in ipairs(arr) do
      table.insert(converted_arr, arabify.convert_2digit(v))
   end
   return converted_arr
end

function arabify.convert_2digit(str)
   local  words = arabify.split(str,'')
   return (arabify.numhash[words[1]] or 0) + (arabify.numhash[words[2]] or 0)
end


function arabify.rollback(str)
   return  arabify.separate_10000(
      string.gsub(string.gsub(string.gsub(str,'፼፻', '፼፩፻'),'^፻', '፩፻'), '^፼', '፩፼')
   )
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

function arabify.separate_10000(str)
   while string.match(str,'፼፼') do
      str = string.gsub(str,'፼፼', '፼ ፼')
   end
   return str
end

return arabify
