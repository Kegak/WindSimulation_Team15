extends Fluid2D
@export var fluid: Fluid2D
@export var objects: Node2D


var points_array: PackedVector2Array
var added_vector: PackedVector2Array
var timer : int = 10
var x : int = 0
var grav_dir_opposite : Vector2 
var dir : Vector2

func _ready() -> void:
	points_array = create_rectangle_points(1,20) # X means rows and Y is Collumns
	added_vector.resize(points_array.size())
	var gravity_value = ProjectSettings.get("physics/2d/default_gravity")
	var gravity_dir = ProjectSettings.get("physics/2d/default_gravity_vector")
	grav_dir_opposite.x = 5
	grav_dir_opposite.y = gravity_dir.x
	dir = global_transform.basis_xform(grav_dir_opposite * gravity_value)
	added_vector.fill(dir)
	

func _process(delta: float) -> void:
	if x % 10 == 0:
		add_points_and_velocities(points_array, added_vector)
	x+=1
	# 100,000 kg for object mass is a decent weight for something light but add 8x gravity scale for object that is hard to move
	var all_objects = objects.get_children()
	for object in all_objects:
		var collsion_zone = object.get_child(0)
		var height = collsion_zone.shape.size.y
		var width = collsion_zone.shape.size.x
		print(object.transform.x)
		
