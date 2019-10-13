--------------------------------------------------------------------------------
-- UnitTest
--------------------------------------------------------------------------------
UnitTest = class(function(o, name)
  o.name = name
end)

function UnitTest:Equals(result, expectation)
  if result ~= expectation then
    print("Fail: " .. self.name)
    print("      Expected " .. JSON.encode(result) .. " to equal " .. JSON.encode(expectation))
    return false
  end
  print("Pass: " .. self.name)
  return true
end

function UnitTest:True(result)
  return self:Equals(result, true)
end

function UnitTest:False(result)
  return self:Equals(result, false)
end

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
function describe(name, callback)
  callback(function(description, testCallback)
    testCallback(UnitTest(name .. ' ' .. description))
  end)
end
