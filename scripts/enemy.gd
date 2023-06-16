extends CharacterBody2D

const SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var moving = false
var direction = 1
var isHit = false

signal died

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation_Body.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()


func _on_movement_timer_timeout():
	moving = !moving
	$Animation_Body.flip_h = direction < 0
	
	if not isHit:
		if moving:
			$Animation_Body.play("run")
			velocity.x = SPEED * direction
			direction = (-1) * direction
		else:
			$Animation_Body.play("idle")
			velocity.x = 0


func _on_hit_box_area_entered(area):
	if area.is_in_group("Projectiles"):
		died.emit()
		isHit = true
		$Animation_Body.play("hit")
		$Audio_Hit.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
