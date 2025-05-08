##WindGeneration uses Lattice Boltzmann Logic when colliding with a Rectangle, or Circle Object.
class_name WindGeneration extends Fluid2D
##Add your Fluid2D Node to this script in the inspector, after attaching this script to the Fluid2D Node
@export var fluid: Fluid2D
##A Node2D that is the parent of all the collision objects in a scene (Add in the Inspector)
@export var objects: Node2D
##The amount of particles you want for the y access (x will always be 1)
@export var y: int
## Var that determins speed of wind
@export var wind_speed : int = 5
##An Array that contains all the points in the fluid with their vector placements from the fluid origin (not the scene origin)
var points_array: PackedVector2Array
##Contains the velocity that will be applied to the points on the next frame
var added_vector: PackedVector2Array
##Is used to spawn particles every 4 frames
var timer : int = 0
##Helps counteract gravity
var grav_dir_opposite : Vector2 
##Let's us shoot the fluid sideways
var dir : Vector2
##A boolean that changes when the spacebar is pressed, so the wind can be started and stopped.
var spawning : bool
## A int to determine how often wind particles spawn
var frames : int = 4
var rng = RandomNumberGenerator.new()

func _input(_e):
	if Input.is_action_just_pressed("pause"):
		spawning = !spawning

func _ready() -> void:
	spawning = true 
	points_array = create_rectangle_points(1,y) # X means Collumns and Y is Rows
	added_vector.resize(points_array.size())
	var gravity_value = ProjectSettings.get("physics/2d/default_gravity")
	var gravity_dir = ProjectSettings.get("physics/2d/default_gravity_vector")
	grav_dir_opposite.x = wind_speed
	grav_dir_opposite.y = gravity_dir.x
	dir = global_transform.basis_xform(grav_dir_opposite * gravity_value)
	added_vector.fill(dir)

func _process(_delta: float) -> void:
	var random_Num = rng.randi_range(0,10000)
	if random_Num < 3900 && random_Num > 3800:
		if frames < 6:
			frames += 1
	elif random_Num < 8900 && random_Num > 8800:
		if frames > 2:
			frames -= 1
		else:
			frames = 4
	if timer % frames == 0 && spawning:
		add_points_and_velocities(points_array,added_vector)
	fluid_collision(fluid.points, fluid.get_velocities(), objects.get_children())
	timer += 1
	
##Runs the bolzmann algorthim on collsion (Lattice is handled by Fluid2D)
func boltzmann() -> Vector2:
	var boltzmann_weights = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,3,3,3,3,4,5,5,5,5,6,7,7,7,7,8]
	var directions = [[0,0], [0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]]
	var random_number = rng.randi_range(0, 35)
	var vect = directions[boltzmann_weights[random_number]]
	var vector = Vector2(vect[0], vect[1])
	return vector

## Checks each frame if a fluid is colliding with an object
func fluid_collision(fpoints, velocities, all_objects):
	for object in all_objects:
		var collsion_zone = object.get_child(0)
		if object.body_entered:
			var index = 0;
			if (collsion_zone.get_shape() is RectangleShape2D ):
				var height = collsion_zone.shape.size.y
				var width = collsion_zone.shape.size.x
				for point in fpoints:
					if ((object.get_global_transform()[2][0] - (width/2) <= (fluid.get_global_transform()[2][0] + point.x)) and ((fluid.get_global_transform()[2][0] + point.x) <= object.get_global_transform()[2][0] + (width/2))) and ((object.get_global_transform()[2][1] - (height/2) <= (fluid.get_global_transform()[2][1] + point.y)) and ((fluid.get_global_transform()[2][1] + point.y) <= object.get_global_transform()[2][1] + (height/2))):
						velocities.set(index, boltzmann())
						set_points_and_velocities(fpoints, velocities)
					index += 1
					
			if (collsion_zone.get_shape() is CircleShape2D):
				var fradius = collsion_zone.shape.radius
				for point in points:
					if (((fluid.get_global_transform()[2][0] + point.x) - object.get_global_transform()[2][0])**2 + ((fluid.get_global_transform()[2][1] + point.y) - object.get_global_transform()[2][1])**2) < fradius**2:
						velocities.set(index, boltzmann())
						set_points_and_velocities(fpoints, velocities)
					index += 1
	
