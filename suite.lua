require("unit")

package.path = package.path .. ";./../?.lua"
-- test files are required here
require('tests')
-- require('failing_tests')

-- final report is ran here
Unit:report()
