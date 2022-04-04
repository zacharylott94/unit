require("unit")

-- a suite looks like this. Invoke Unit.suite with the suite name and then a list of tests
local suite = Unit.suite("tests for the framework itself", {

  -- Tests look like this, Invoke Unit.test with the name for the test and a function that sets up your testing environment
  -- This passed function at minimum needs to return whether or not the test has passed
  -- The second return value is the value the test produced. The third return value is the value you were expecting the test to produce
  Unit.test("tests work", function() 
    return {
      Unit.equals(true,true),
      Unit.equals(false,false),
      -- Unit.equals(true, false), -- intentionally fail
      -- Unit.equals(1,2), -- intentionally fail
      Unit.equals(2,2)
    }
  end),

  Unit.test("Deep equals works", function()
    local actual = {1,2,3}
    local expected = {1,2,3}
    return {
      Unit.deepEquals(actual, expected),
      Unit.shouldFail(Unit.deepEquals({2,3,4},{1,2,3})), --  intentionally fail
      Unit.shouldFail(Unit.deepEquals({},{"literally any value"})) ,--should fail
      Unit.deepEquals({},{}) --should pass
    }
  end)

})

Unit.report(suite)