extends Node

@onready var player = $Player
@onready var HUD = $HUD

@onready var mobClass = preload("res://scenes/enemy.tscn")
@onready var itemClass = preload("res://scenes/item01.tscn")

@onready var currentLevel = preload("res://scenes/level02.tscn")

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.setMaxHearts(player.maxHealth)
	newLevel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func newLevel():
	var level = currentLevel.instantiate()
	add_child(level)
	
	player.position = level.Start.position
	var enemySpawners = level.EnemySpawnerGroup.get_children()
	for i in enemySpawners:
		var enemy = mobClass.instantiate()
		enemy.position = i.position
		enemy.connect("died", _on_mob_died )
		add_child(enemy)
	
	var itemSpawner = level.ItemSpawnerGroup.get_children()
	for i in itemSpawner:
		var item = itemClass.instantiate()
		item.position = i.position
		add_child(item)


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


func _on_mob_died():
	score += 1
	HUD.updateScore(score)
