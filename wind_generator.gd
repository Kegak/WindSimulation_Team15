extends Sprite2D

var particle = preload("res://wind_particle.tscn")

func inst(pos) -> void:
	var instance = particle.instantiate()
	add_child(instance)
	instance.position = Vector2(0,75)

func _process(_delta: float) -> void:
	var location = $".".global_position
	inst(location)
