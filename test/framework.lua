UnitTest = {
  name = "Undefined"
}

function UnitTest:new(name)
  o = { name = name }
  setmetatable(o, self)
  self.__index = self
  return o
end

function UnitTest:AssertEquals(result, expectation)
  if result ~= expectation then
    print("Fail: " .. self.name)
    print("      Expected " .. JSON.encode(result) .. " to equal " .. JSON.encode(expectation))
    return
  end
  print("Pass: " .. self.name)
end
