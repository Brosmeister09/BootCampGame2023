extends Node

@onready var player = $Player
@onready var HUD = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.setMaxHearts(player.maxHealth)
	new_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func new_level():
	player.position = $Level/Start.position


# Handle respawn signal
func _on_player_respawn():
	player.position = $Level/Start.position
	player.velocity.x = 0
	player.velocity.y = 0


# Handle death of palyer
func _on_player_died():
	# show "You Died" Screen before reload
	get_tree().change_scene_to_file("res://scenes/defeatscreen.tscn")


func _on_player_health_changed(currentHealth):
	HUD.updateHealth(currentHealth)
	
func _on_player_score_changed(currentScore):
	HUD.updateScore(currentScore)
