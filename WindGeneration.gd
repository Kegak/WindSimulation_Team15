class_name WindGeneration extends Fluid2D
@export var fluid: Fluid2D
@export var objects: Node2D


var points_array: PackedVector2Array
var added_vector: PackedVector2Array
var timer : int = 10
var x : int = 0
var grav_dir_opposite : Vector2 
var dir : Vector2

func _ready() -> void:

	points_array = create_rectangle_points(1,1) # X means rows and Y is Collumns

	added_vector.resize(points_array.size())
	var gravity_value = ProjectSettings.get("physics/2d/default_gravity")
	var gravity_dir = ProjectSettings.get("physics/2d/default_gravity_vector")
	grav_dir_opposite.x = 5
	grav_dir_opposite.y = gravity_dir.x
	dir = global_transform.basis_xform(grav_dir_opposite * gravity_value)
	added_vector.fill(dir)
	

func _process(delta: float) -> void:

	if x % 5 == 0:
		add_points_and_velocities(points_array,added_vector)
	var points = fluid.points
	var velocities = fluid.get_velocities()
	for i in velocities.size():
		if velocities[i].x < -10:
			if velocities[i].y > 10:
				velocities.set(i, Vector2(-10, 10))
			else:
				velocities.set(i, Vector2(-10,velocities[i].y))
		if velocities[i].y > 10:
			if velocities[i].x < -10:
				velocities.set(i, Vector2(-10, 10))
			else:
				velocities.set(i, Vector2(velocities[i].x, 10))
	fluid.set_points_and_velocities(points, velocities)
	var all_objects = objects.get_children()
	for object in all_objects:
		var collsion_zone = object.get_child(0)
		if object.body_entered:
			var index = 0;
			if (collsion_zone.get_shape() is RectangleShape2D ):
				var height = collsion_zone.shape.size.y
				var width = collsion_zone.shape.size.x
				for point in points:
					if ((object.get_global_transform()[2][0] - (width/2) <= point.x) and (point.x <= object.get_global_transform()[2][0] + (width/2))) and ((object.get_global_transform()[2][1] - (height/2) <= point.y) and (point.y <= object.get_global_transform()[2][1] + (height/2))):
						velocities.set(index, collsion())
						#set_points_and_velocities(fluid.points, velocities)
					index += 1
					
			if (collsion_zone.get_shape() is CircleShape2D):
				var radius = collsion_zone.shape.radius
				for point in points:
					if ((point.x - object.get_global_transform()[2][0])**2 + (point.y - object.get_global_transform()[2][1])**2) < radius**2:
						velocities.set(index, collsion())
						#set_points_and_velocities(fluid.points, velocities)
					index += 1
		
	
func collsion() -> Vector2:
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(1, 36)
	if (my_random_number >= 1) and (my_random_number <= 16):
		return Vector2(0,0) 
	if (my_random_number >= 17) and (my_random_number <= 20):
		return Vector2(0,1) 
	if (my_random_number == 21):
		return Vector2(1,1) 
	if (my_random_number >= 22) and (my_random_number <= 25):
		return Vector2(1,0) 
	if (my_random_number == 26):
		return Vector2(1,-1)
	if (my_random_number >= 27) and (my_random_number <= 30):
		return Vector2(0,-1)  
	if (my_random_number == 31):
		return Vector2(-1,-1) 
	if (my_random_number >= 32) and (my_random_number <= 35):
		return Vector2(-1,0) 
	if (my_random_number == 36):
		return Vector2(-1,1) 
	return Vector2(0,0)
