local geezify = require('geezify-lua')
local test_data = require('test_case')

describe('geezify', function()
	    it('should convert every number in the test data to its equivalent geez number', function()
		  for i,v in ipairs(test_data) do
		     print(v[1])
		     assert.equal(geezify.geezify(v[1]), v[2])
		  end
  end)
end)

