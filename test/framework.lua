--------------------------------------------------------------------------------
-- UnitTest
--------------------------------------------------------------------------------
UnitTest = class(function(o, name)
  o.name = name
end)

function UnitTest:AssertEquals(result, expectation)
  if result ~= expectation then
    print("Fail: " .. self.name)
    print("      Expected " .. JSON.encode(result) .. " to equal " .. JSON.encode(expectation))
    return
  end
  print("Pass: " .. self.name)
end

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
function describe(name, callback)
  print('Running Test Suite: ' .. name)
  callback(function(description, testCallback)
    testCallback(UnitTest(description))
  end)
  print('')
end
