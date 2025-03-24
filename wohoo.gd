extends Fluid2D
@export var fluid: Fluid2D
@export var objects: Node2D


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
	var all_objects = objects.get_children()
	for object in all_objects:
		var collsion_zone = object.get_child(0)
		var height = collsion_zone.shape.size.y
		var width = collsion_zone.shape.size.x
		if object.body_entered:
			for point in points:
				if ((object.position.x - width/2 <= point.x) and (point.x <= object.position.x + width/2)) and ((object.position.y - height/2 <= point.y) and (point.y <= object.position.y + height/2)):
					print(point) 
		
	for i in points.size():
		if points[i].y >= 0:
			points[i].y = 0
		fluid.points[i] = points[i]
	x += 1
	
func collsion():
	var points = fluid.points


func _on_rigid_body_2d_2_body_entered(body: Node) -> void:
	print("working")
