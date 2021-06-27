local geezifylua = require('geezifylua')
local test_data = require('test_case')

describe('bothways_test', function()
            it('converting a number one way and returning it back should yield the same result', function()
                  for i = 1, 10000, 1 do
                     math.randomseed(os.clock()*100000000000)
                     r1 = math.random(99999999)

                     print(string.format("%d ==> %s  ==> %d",
                                         r1,
                                         geezifylua.geezify.geezify(r1),
                                         geezifylua.arabify.arabify(geezifylua.geezify.geezify(r1))))

                     assert.equal(geezifylua.arabify.arabify(geezifylua.geezify.geezify(r1)), r1)
                  end
  end)
end)
