export interface IOwner {
  character: string;
  realm: string;
}

export interface ITimestamp {
  hours: number;
  minutes: number;
}

export interface ILocationEntry {
  name: string;
  isInstance: boolean;
}

export interface ILogEntry {
  timestamp: ITimestamp;
  owner: IOwner;
  isReset: boolean;
  location: ILocationEntry;
}

export interface IInstanceLock {
  location: ILocationEntry;
  owner: IOwner;
  enteredAt: ITimestamp;
  exitedAt?: ITimestamp;
  logs: ILogEntry[];
}
