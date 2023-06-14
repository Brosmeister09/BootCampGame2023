extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	new_level()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func new_level():
	$Player.position = $Level/Start.position


func _on_player_fallen():
	$Player.position = $Level/Start.position
	$Player.velocity.x = 0
	$Player.velocity.y = 0
