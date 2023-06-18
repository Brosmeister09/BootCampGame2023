extends Area2D

const SPEED = 300.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation_Projectile.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += direction * SPEED * delta


# handle collision with areas
func _on_area_entered(area):
	if not (area.is_in_group("Player") or area.is_in_group("Projectiles")):
		destroy()


# handle collision with bodies
func _on_body_entered(body):
	if not (body.is_in_group("Player") or body.is_in_group("Projectiles")):
		destroy()


# destroy projectile if it leaves the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()


# remove self from scene
func destroy():
	queue_free()
