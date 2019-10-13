local Owner = OUtils:Class({
  character: nil,
  realm: nil,
})

local Timestamp = {
  hours: nil,
  minutes: nil,
}

local LocationEntry = {
  name: nil,
  isInstance: false,
}

local ILogEntry = {
  timestamp: ITimestamp;
  owner: IOwner;
  isReset: boolean;
  location: ILocationEntry;
}

local IInstanceLock = {
  location: ILocationEntry;
  owner: IOwner;
  enteredAt: ITimestamp;
  exitedAt?: ITimestamp;
  logs: ILogEntry[];
}
