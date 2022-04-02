Unit = {}

-- Well, kinda deep. First level, anyway
function Unit.deepEquals(test,expected)
  local isEqual = true
  for k,v in pairs(test) do
    if expected[k] ~= v then isEqual = false end
  end
  if isEqual then
      return true
  else
      return false
  end
end

function Unit.report(suite)
  local list = require("list")
  local h = require("lambda")
  local isPassing = function (test) 
    return test.passed
    end
  local isNotPassing = h.compose(isPassing, h.fnot)
  local total = #suite
  local passed = list.filter(isPassing)(suite)
  local failed = list.filter(isNotPassing)(suite)
    print(string.format("| %s |",suite.name))
    print(string.format("| %s total test(s). %s test(s) passed. %s test(s) failed. |\n____________", total, #passed, #failed ))
    for _,test in pairs(failed) do
      print(string.format("FAILED | %s | Actual: %s | Expected: %s", test.name, test.actual, test.expected))
    end
end

function Unit.test(name, fun)
  local passed, actual, expected = fun()

  return {
    name = name,
    passed = passed,
    actual = actual,
    expected = expected,
  }

end

function Unit.suite(name, tests)
  local mt = {
    __index = function(t, index)
      if index == "name" then
        return name
      else
        return t[index]
      end
    end
  }
  return setmetatable(tests, mt) --does this still iterate over name?
end