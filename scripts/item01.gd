extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation_Item.play("default")
