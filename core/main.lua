local name = ...

local InstanceTracker = LibStub('AceAddon-3.0'):NewAddon(name, 'AceConsole-3.0', 'AceEvent-3.0')

function InstanceTracker:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New('InstanceTrackerDB', {
    global = {}
  })
  self.store = REDUX:createStore()
  self.store:dispatch(action(STORE_ACTIONS.Load, self.db.global))
  self.store:subscribe(function()
    self.db.global = self.store:getState()
  end)
end
