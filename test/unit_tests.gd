extends GutTest


var wind_generator: WindGeneration


func before_each():
	wind_generator = WindGeneration.new()
	add_child(wind_generator)

##Makes sure wind is spawning on scene start
func test_initial_spawn():
	assert_true(wind_generator.spawning, "Spawning should be true after the ready function")

##Makes sure that boltzmann returns the correct value
func test_boltzmann_return():
	var result = wind_generator.boltzmann()
	assert_true(result is Vector2, "boltzmann should have return a Vector2")
	
##Check wind speed greater than zero
func test_wind_speed_is_greater_than_zero():
	assert_gt(wind_generator.wind_speed, 0, "Wind was set to either zero or less than zero, wind needs speed.")
	

## checks to see if there is more than one row of wind, which is known to cause issues in some rooms
func test_is_there_more_than_one_wind_row():
	assert_gt(wind_generator.rows_of_wind, 1, "Amount of wind is too low.")
	
