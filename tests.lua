Unit:test("equals passes if equal", function()
  Unit:equals(true,true)
end)

Unit:test("notEqual passes if not equal", function()
  Unit:notEqual(true,false)
end)

Unit:test("Expect returns itself with a value for 'arg'", function()
  Expect("test")
  Unit:equals(Expect.arg,"test")
end)

Unit:test("Expect.toBe() passes if equal", function()
  Expect(true):toBe(true)
end)

Unit:test("Expect.toNotBe() passes if not equal", function()
  Expect(true):toNotBe(false)
end)

Unit:test("Expect.toBeTrue() passes if given value is true", function()
  Expect(true):toBeTrue()
end)

Unit:test("Expect.toBeFalse() passes if given value is false", function()
  Expect(false):toBeFalse()
end)

Unit:test("Expect.toNotBeTrue() passes if given value is not true", function()
  Expect(false):toNotBeTrue()
end)

Unit:test("Expect.toNotBeFalse() passes if given value is not false", function()
  Expect(true):toNotBeFalse()
end)

Unit:test("deepEquals() passes if it can compare the first level of two tables", function()
  Unit:deepEquals({1,2,3},{1,2,3})
end)