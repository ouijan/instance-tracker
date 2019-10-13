require './lib/Json/json';
require './core/class';
require './test/framework';

describe('Basic Examples', function(it)

  it('Assert Equals - Passes', function(o)
    o:AssertEquals('itemA', 'itemA')
  end)

  it('Assert Equals - Fails', function(o)
    o:AssertEquals('itemA', 'itemB')
  end)

end)
