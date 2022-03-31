Unit:test("equals fails if not equal", function()
  Unit:equals(true,false)
end)

Unit:test("notEqual fails if equal", function()
  Unit:notEqual(true,true)
end)

Unit:test("Expect.toBe() fails if not equal", function()
  Expect(true):toBe(false)
end)

Unit:test("Expect.toNotBe() fails if equal", function()
  Expect(true):toNotBe(true)
end)

Unit:test("Expect.toBeTrue() passes if given value is true", function()
  Expect(false):toBeTrue()
end)

Unit:test("Expect.toBeFalse() passes if given value is false", function()
  Expect(true):toBeFalse()
end)

Unit:test("Expect.toNotBeTrue() fails if given value is not true", function()
  Expect(true):toNotBeTrue()
end)

Unit:test("Expect.toNotBeFalse() fails if given value is not false", function()
  Expect(false):toNotBeFalse()
end)


Unit:test("Multiple checks can give more than one problem", function()
  Expect(true):toBeFalse()
  Expect(false):toBeTrue()
end)
