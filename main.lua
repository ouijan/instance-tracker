require "./lib/Json/json";
require "./test/framework";

local ut = UnitTest:new("Basic Example")
ut:AssertEquals("itemA", "itemB")
