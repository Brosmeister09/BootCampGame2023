extends Area2D

signal levelChange

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("idle")


# handle collision and emit level changed
func _on_area_entered(area):
	if area.is_in_group("Player"):
		levelChange.emit()
