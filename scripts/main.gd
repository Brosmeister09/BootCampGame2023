extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	new_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func new_level():
	$Player.position = $Level/Start.position


# Handle respawn signal
func _on_player_respawn():
	$Player.position = $Level/Start.position
	$Player.velocity.x = 0
	$Player.velocity.y = 0


func _on_player_died():
	get_tree().reload_current_scene()
	### TODO maybe add "You Died" Screen before reload later
