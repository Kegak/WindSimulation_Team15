extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_jacob_room_pressed() -> void:
	get_tree().change_scene_to_file("res://RoomJacob.tscn")
	#pass # Replace with function body.


func _on_button_keegan_room_pressed() -> void:
	get_tree().change_scene_to_file("res://big_room_with_window.tscn")
	#pass # Replace with function body.


func _on_button_james_room_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d_james.tscn")
	#pass # Replace with function body.


func _on_button_alt_room_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d_alt.tscn")
	#pass # Replace with function body.


func _on_button_teagan_room_pressed() -> void:
	get_tree().change_scene_to_file("res://ZimmerMitTur.tscn")
	#pass # Replace with function body.

func _on_button_base_room_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
	#pass # Replace with function body.

#I think i configured the button wrong for this one or set up all the other buttons for the main menu in the wrong script.
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	#pass # Replace with function body.
