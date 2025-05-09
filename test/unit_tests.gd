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
