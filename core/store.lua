StoreActions = {
  Load = "Load",
  TrackLocation = "TrackLocation",
  ResetInstances = "ResetInstances",
}

function action(type, data)
  return {
    type = type,
    data = data or {}
  }
end

local function reducer(state, action)
  if state == nil then state = {} end
  if action.type == StoreActions.Load then
    return action.data
  else
    return state
  end
end

function getStore(state)
  local store = REDUX.createStore(reducer)
  store:dispatch(action(StoreActions.Load, state or {}))
  return store
end
