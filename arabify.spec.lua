local geezify = require('arabify')
local test_data = require('test_case')

describe('arabify', function()
	    it('should convert every geez number in the test data to its equivalent arab number', function()
		  for i,v in ipairs(test_data) do
		     print(v[2])
		     assert.equal(arabify.arabify(v[2]), v[1])
		  end
  end)
end)
