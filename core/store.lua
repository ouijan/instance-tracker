EMPTY_STATE = {
  locks = {},
  locksThisReset = {},
  currentInstance = {},
}

function action(action, data)
  return {
    type = action.type,
    data = data
  }
end

------------------------------------------
-- SetStateAction
------------------------------------------
SetStateAction = { type = 'SetStateAction' }
function SetStateAction:reduce(data, state)
  return data
end

------------------------------------------
-- TrackLocationAction
------------------------------------------
local function instanceOwnerKey(data)
  return data.owner.character .. '-' .. data.owner.realm
end

local function instanceLockKey(data)
  return instanceOwnerKey(data) .. ':' .. data.location.name
end

local function trackInstance(data, state)
  local lockKey = instanceLockKey(data)
  local existingLock = state.locksThisReset[lockKey]
  if existingLock then
    table.insert(existingLock.logs, data)
  else
    state.locksThisReset[lockKey] = {
      location = data.location,
      owner = data.owner,
      enteredAt = data.timestamp,
      logs = { data },
    };
  end
  local ownerKey = instanceOwnerKey(data)
  state.currentInstance[ownerKey] = lockKey
  return state
end

local function trackWorld(data, state)
  local ownerKey = instanceOwnerKey(data)
  local currentLockKey = state.currentInstance[ownerKey]
  local currentLock = state.locksThisReset[currentLockKey]
  if currentLock then
    currentLock.exitedAt = data.timestamp;
    table.insert(currentLock.logs, data)
  end
  state.currentInstance[ownerKey] = nil
  return state
end

TrackLocationAction = { type = 'TrackLocationAction' }
function TrackLocationAction:reduce(data, state)
  if data.location.isInstance then
    return trackInstance(data, state)
  else
    return trackWorld(data, state)
  end
end

------------------------------------------
-- ResetInstancesAction
------------------------------------------
ResetInstancesAction = { type = 'ResetInstancesAction' }
function ResetInstancesAction:reduce(data, state)
  for k, lock in pairs(state.locksThisReset) do
    table.insert(state.locks, lock)
  end
  state.locksThisReset = {}
  state.currentInstance = {}
  return state
end

------------------------------------------
-- ResetInstancesAction
------------------------------------------
local function stateReducer(state, action)
  if action.type == SetStateAction.type then
    return SetStateAction:reduce(action.data, state)
  elseif action.type == TrackLocationAction.type then
    return TrackLocationAction:reduce(action.data, state)
  elseif action.type == ResetInstancesAction.type then
    return ResetInstancesAction:reduce(action.data, state)
  else
    return state
  end
end

function initStore(initialState)
  local store = REDUX.createStore(stateReducer)
  store:dispatch(action(SetStateAction, initialState or EMPTY_STATE))
  return store
end
