require("unit")

-- a suite looks like this. Invoke Unit.suite with the suite name and then a list of tests
local suite = Unit.suite("tests for the framework itself", {

  -- Tests look like this, Invoke Unit.test with the name for the test and a function that sets up your testing environment
  -- This passed function at minimum needs to return whether or not the test has passed
  -- The second return value is the value the test produced. The third return value is the value you were expecting the test to produce
  Unit.test("tests work", function() 
    return true
  end),
})

Unit.report(suite)