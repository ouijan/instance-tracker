Owner = class(function (o, data)
  o.character = data.character
  o.realm = data.realm
end)

Timestamp = class(function(o, data)
  o.hours = data.hours
  o.minutes = data.minutes
end)

Location = class(function(o, data)
  o.name = data.name
  o.isInstance = data.isInstance
end)

-- ILogEntry = class(function(o, data)
--   o.timestamp = data.timestamp
--   o.owner = data.owner
--   o.isReset = data.isReset
--   o.location = data.location
-- end)

-- IInstanceLock = class(function(o, data)
--   o.location = data.location
--   o.owner = data.owner
--   o.enteredAt = data.enteredAt
--   o.exitedAt = data.exitedAt
--   o.logs = data.logs or {}
-- end)
