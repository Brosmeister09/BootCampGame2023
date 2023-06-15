extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Audio_Defeat.play()
	

# Handle timer
func _on_timer_defeated_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
