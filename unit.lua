-- stolen from https://www.codegrepper.com/code-examples/lua/lua+table+pretty+print
local function dump(o)
  if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
              if type(k) ~= 'number' then k = '"'..k..'"' end
              s = s  ..k..':' .. dump(v) .. ','
      end
      return s .. '} '
  else
      return tostring(o)
  end
end




Unit = {}

-- Well, kinda deep. First level, anyway
function Unit.deepEquals(test,expected)
  if (#test == 0) and (#expected == 0) then return end
  local isEqual = false
  for k,v in pairs(test) do
    if expected[k] ~= v then 
      isEqual = false
      break
    else 
      isEqual = true 
    end
  end
  if isEqual then
      return 
  else
      return {
        actual = dump(test),
        expected = dump(expected)
      }
  end
end

function Unit.equals(actual, expected)
  if actual == expected then return end
  return {
    actual = actual,
    expected = expected,
  }
end

function Unit.shouldFail(val)
  if val then return end
  return {
    expected = "A problem",
    actual = "No problem"
  }
end

function Unit.report(suite)
  local list = require("list")
  local h = require("lambda")
  local isPassing = function (test) 
    return (#test.problems == 0)
    end
  local isNotPassing = h.compose(isPassing, h.fnot)
  local total = #suite
  local passed = list.filter(isPassing)(suite)
  local failed = list.filter(isNotPassing)(suite)
    print(string.format("| %s |",suite.name))
    print(string.format("| %s total test(s). %s test(s) passed. %s test(s) failed. |\n____________", total, #passed, #failed ))
    for _,test in pairs(failed) do
      print(string.format("FAILED | %s", test.name))
      for _,problem in pairs(test.problems) do
        print(string.format("\tactual: %s, Expected:%s", problem.actual, problem.expected))
      end
    end
end

function Unit.test(name, fun)
  local problems = fun()

  return {
    name = name,
    problems = problems
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
  return setmetatable(tests, mt) --does this still iterate over name? --It does not
end