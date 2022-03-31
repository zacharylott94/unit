local function failString(name,val1,val2)
  return name .. ": Expected " .. tostring(val1) .. " to be " .. tostring(val2)
end
----------------------------------
Unit = {
    passed=0,
    results={},
    count=0,
    current=nil,
    problems={}
}
function Unit:fail(problem)
    self.current = false
    table.insert(self.problems,problem)
end

function Unit:pass()
    if self.current ~= false
    then
      self.current =  true
    end
end

function Unit:result()
  if self.current then
    table.insert(self.results,"good")
    self.passed = self.passed + 1
  else
    for k,v in pairs(self.problems) do
      table.insert(self.results,v)
    end
  end
end

function Unit:equals(test,expected)
    if test == expected then
        self:pass()
    else
        self:fail(self.testName)
    end
end

-- Well, kinda deep. First level, anyway
function Unit:deepEquals(test,expected)
  local isEqual = true
  for k,v in pairs(test) do
    if expected[k] ~= v then isEqual = false end
  end
  if isEqual then
      self:pass()
  else
      self:fail(self.testName)
  end
end

function Unit:test(testName, testWrapperFunction)
    self.count = self.count + 1
    self.testName = tostring(self.count) .."| " .. testName
    testWrapperFunction()
    self.testName = nil
    self:result()
    self.current = nil
    self.problems = {}

end

function Unit:report()
    print("\n" .. tostring(self.count) .. " total test(s).  " .. tostring(self.passed) .. " test(s) passed.  " .. tostring(self.count - self.passed) .. " test(s) failed." .. "\n____________" )
    local i = 1
    while self.results[i] ~= nil do
        if not (self.results[i] == "good") then
        print("FAILED " .. self.results[i])
        end
        i = i + 1
    end
    print()
end

function Unit:notEqual (test, expected)
  if test ~= expected then
      self:pass()
  else
      self:fail(self.testName)
  end
end

ExpectMT = {
  __call = function(t,a)
    t.arg = a
    return t
  end
}
Expect = {}
setmetatable(Expect,ExpectMT)

function Expect:toBe (compare)
  if self.arg == compare
  then
    Unit:pass()
  else
    Unit:fail(failString(Unit.testName, compare, self.arg))
  end
  self.arg = nil
end

function Expect:toNotBe (compare)
  if self.arg ~= compare
  then
    Unit:pass()
  else
    Unit:fail(Unit.testName .. ": " .. tostring(compare) .. " and " .. tostring(self.arg) .. " are equal.")
  end
  self.arg = nil
end

function Expect:toBeTrue ()
  if self.arg == true
  then
    Unit:pass()
  else
    Unit:fail(failString(Unit.testName, self.arg, true))
  end
  self.arg = nil
end

function Expect:toNotBeFalse ()
  self.toBeTrue(self)
end

function Expect:toBeFalse ()
  if self.arg == false
  then
    Unit:pass()
  else
    Unit:fail(failString(Unit.testName,self.arg,false))
  end
  self.arg = nil
end

function Expect:toNotBeTrue ()
  self.toBeFalse(self)
end

--------------------
