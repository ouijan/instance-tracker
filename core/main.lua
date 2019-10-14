local name = ...

local InstanceTracker = LibStub('AceAddon-3.0'):NewAddon(name, 'AceConsole-3.0', 'AceEvent-3.0')

function InstanceTracker:OnInitialize()
  self.db = LibStub('AceDB-3.0'):New('InstanceTrackerDB', {
    global = {}
  })
  self.store = initStore(self.db.global)
  self.store:subscribe(function()
    self.db.global = self.store:getState()
  end)
end

function InstanceTracker:CurrentLocationData()
  local hours, minutes = GetGameTime()
  return {
    timestamp = {
      hours = hours,
      minutes = minutes,
    },
    owner = {
      realm = GetRealmName(),
      character = UnitName('player')
    },
    location = {
      name = GetInstanceInfo(),
      isInstance = IsInInstance(),
    },
  }
end

function InstanceTracker:Debug()
  self:Print(JSON.encode(self.store:getState()))
end
------------------------------------------
-- Events
------------------------------------------
function InstanceTracker:TrackInstanceReset()
  self.store:dispatch(action(ResetInstancesAction, self.CurrentLocationData()))
end

function InstanceTracker:TrackLocation()
  self.store:dispatch(action(TrackLocationAction, self.CurrentLocationData()))
end
InstanceTracker:RegisterEvent('PLAYER_ENTERING_WORLD', 'TrackLocation')

------------------------------------------
-- CLI
------------------------------------------
local function commandHelp(command, description)
  local colour = 'FFFF00'
  return '|cff' .. colour .. '/it ' .. command .. '|r ' .. description
end

function InstanceTracker:CLI_ShowHelp()
  self:Print("Available Commands:")
  self:Print(commandHelp('reset', 'track an instance reset'))
  self:Print(commandHelp('location', 'track your current location'))
  self:Print(commandHelp('debug', 'show current state'))
end

function InstanceTracker:CLI(input)
  local command, arg1 = self:GetArgs(input, 2)
  if command == 'reset' then
    self:TrackInstanceReset()
    self:Print('Instance Reset has been tracked')
  elseif command = 'location' then
    self:TrackLocation()
    self:Print('Location has been tracked')
  elseif command = 'debug' then
    self:Debug();
  else
    self:CLI_ShowHelp()
  end
end
