extends Node2D

@export var Start: Marker2D
@export var End: Marker2D
@export var EnemySpawnerGroup: Node
@export var ItemSpawnerGroup: Node
@export var nextLevel: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	Start = $Start
	End = $End
	EnemySpawnerGroup = $EnemySpawnerGroup
	ItemSpawnerGroup = $ItemSpawnerGroup


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
