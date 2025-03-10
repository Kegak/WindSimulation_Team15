extends Fluid2D
@export var fluid: Fluid2D

var new_points: PackedVector2Array
var starting_vectors: PackedVector2Array
var timer : int = 10
var x : int = 0
var grav_dir_opposite : Vector2 

func _ready() -> void:
	new_points = create_circle_points(1)
	starting_vectors.resize(new_points.size())
	var gravity_value = ProjectSettings.get("physics/2d/default_gravity")
	var gravity_dir = ProjectSettings.get("physics/2d/default_gravity_vector")
	grav_dir_opposite.x = 1
	grav_dir_opposite.y = gravity_dir.x
	var dir = global_transform.basis_xform(grav_dir_opposite * gravity_value)
	starting_vectors.fill(dir)
	

func _process(delta: float) -> void:
	if x % 5 == 0:
		add_points_and_velocities(new_points,starting_vectors)
	var points = fluid.points
	for i in points.size():
		if points[i].y >= 0:
			points[i].y = 0
		fluid.points[i] = points[i]
	x += 1
