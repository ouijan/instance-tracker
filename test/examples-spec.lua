
describe('Basic Examples', function (it)

  it('Assert Equals - Passes', function (assert)
    assert:Equals('itemA', 'itemA')
  end)

  it('Assert Equals - Fails', function (assert)
    assert:Equals('itemA', 'itemB')
  end)

end)
