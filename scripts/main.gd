extends Node

@onready var player = $Player
@onready var HUD = $HUD

@onready var mobClass = preload("res://scenes/enemy.tscn")
@onready var itemClass = preload("res://scenes/item01.tscn")
@onready var portalClass = preload("res://scenes/portal.tscn")
@onready var currentLevelClass = preload("res://scenes/level01.tscn")
@onready var currentLevel = preload("res://scenes/level01.tscn")
var addedScenes = []

var score = 0
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.setMaxHearts(player.maxHealth)
	newLevel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Load level and instantiate enemies, items and portals
func newLevel():
	level = currentLevelClass.instantiate()
	addedScenes.append(level)
	add_child(level)
	
	player.position = level.Start.position
	
	var portal = portalClass.instantiate()
	portal.position = level.End.position
	portal.connect("levelChange", _on_portal_level_change)
	addedScenes.append(portal)
	call_deferred("add_child", portal)
	
	var enemySpawners = level.EnemySpawnerGroup.get_children()
	for i in enemySpawners:
		var enemy = mobClass.instantiate()
		enemy.position = i.position
		enemy.connect("died", _on_mob_died )
		addedScenes.append(enemy)
		call_deferred("add_child", enemy)
	
	var itemSpawner = level.ItemSpawnerGroup.get_children()
	for i in itemSpawner:
		var item = itemClass.instantiate()
		item.position = i.position
		addedScenes.append(item)
		call_deferred("add_child", item)
	


# Handle respawn signal
func _on_player_respawn():
	player.position = level.Start.position
	player.velocity.x = 0
	player.velocity.y = 0


# Handle death of palyer
func _on_player_died():
	# show "You Died" Screen before reload
	get_tree().change_scene_to_file("res://scenes/defeatscreen.tscn")


# Update player health in hearts
func _on_player_health_changed(currentHealth):
	HUD.updateHealth(currentHealth)


# Increase score after kill
func _on_mob_died():
	score += 1
	HUD.updateScore(score)
	

# Change level scene when goal is reached
func _on_portal_level_change():
	for i in addedScenes:
		if i!= null and i.is_inside_tree():
			call_deferred("remove_child", i)
	addedScenes.clear()
	
	if level.nextLevel != null:
		currentLevelClass = level.nextLevel
	newLevel()
