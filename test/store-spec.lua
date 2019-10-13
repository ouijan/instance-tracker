
describe('getStore', function (it)

  it('creates a store with preloaded data', function (assert)
    local state = { foo = 'bar '}
    local store = getStore(state)
    assert:Equals(store:getState(), state)
  end)

end)
