
describe('initStore', function (it)

  it('creates a store with preloaded data', function (assert)
    local state = { foo = 'bar' }
    local store = initStore(state)
    assert:Equals(store:getState(), state)
  end)

  it('can run mock events', function(assert)
    local store = initStore()
    for k, action in pairs(MOCK_EVENTS) do
      store:dispatch(action)
    end
    assert:True(true)
  end)

end)
