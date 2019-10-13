import { LOG_MOCK } from "./log.mock";
import { ILogEntry, IInstanceLock } from "./interfaces";

console.log("LOG_MOCK", LOG_MOCK);

function getInstanceLockKey(entry: ILogEntry): string {
  return `${entry.owner.character}-${entry.owner.realm}:${entry.location.name}`;
}

function findLastInstanceEntry(
  entries: ILogEntry[],
  current: ILogEntry
): ILogEntry | undefined {
  let pastCurrent: boolean = false;
  let result: ILogEntry | undefined = undefined;
  entries.map((entry: ILogEntry) => {
    if (entry === current) {
      pastCurrent = true;
    }
    if (pastCurrent) {
      return false;
    }
    const isSameRealm: boolean = entry.owner.realm === current.owner.realm;
    const isSameCharacter: boolean =
      entry.owner.character === current.owner.character;
    if (isSameRealm && isSameCharacter && entry.location.isInstance) {
      result = entry;
    }
  });
  return result;
}

function getInstanceLocks(entries: ILogEntry[]): IInstanceLock[] {
  let all: IInstanceLock[] = [];

  let locksThisReset: { [key: string]: IInstanceLock } = {};
  entries.map((entry: ILogEntry) => {
    // Handle Reset
    if (entry.isReset) {
      all = [...all, locksThisReset.values];
      locksThisReset = {};
      return;
    }

    // Entering an instance
    if (entry.location.isInstance) {
      const key: string = getInstanceLockKey(entry);
      // Already entered once
      if (locksThisReset[key]) {
        locksThisReset[key].logs.push(entry);
        return;
      }
      locksThisReset[key] = {
        location: entry.location,
        owner: entry.owner,
        enteredAt: entry.timestamp,
        logs: [entry]
      };
    }

    // Exiting an instance
    const lastInstance: ILogEntry | undefined = findLastInstanceEntry(
      entries,
      entry
    );
    if (!lastInstance) {
      return;
    }
    const key: string = getInstanceLockKey(entry);
    if (locksThisReset[key]) {
      locksThisReset[key].exitedAt = entry.timestamp;
      locksThisReset[key].logs.push(entry);
      return;
    }
  });

  return all;
}

const locks: IInstanceLock[] = getInstanceLocks(LOG_MOCK);
console.log("locks", locks);
