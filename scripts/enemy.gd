extends CharacterBody2D

const SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var moving = false
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()


func _on_movement_timer_timeout():
	moving = !moving
	
	$AnimatedSprite2D.flip_h = direction < 0
	
	if(moving):
		$AnimatedSprite2D.play("run")
		velocity.x = SPEED * direction
		direction = (-1) * direction
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = 0
