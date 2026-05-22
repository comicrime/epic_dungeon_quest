extends GdUnitTestSuite

func test_hello():
	var a = 1 
	var b = 2 
	var result = min(a, b)
	
	assert_int(result).is_equal(a)
