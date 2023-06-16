extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation_Projectile.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += direction * speed * delta


func _on_area_entered(area):
	if not (area.is_in_group("Player") or area.is_in_group("Projectiles")):
		destroy()


func _on_body_entered(body):
	if not (body.is_in_group("Player") or body.is_in_group("Projectiles")):
		destroy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()


func destroy():
	queue_free()
