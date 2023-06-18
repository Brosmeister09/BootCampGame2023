extends Node2D


# Handle timer
func _on_timer_title_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
