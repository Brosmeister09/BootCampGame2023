extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.00

signal fallen

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hasDoubleJumped = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("up") and (is_on_floor() or not hasDoubleJumped):
		velocity.y = JUMP_VELOCITY
		
		hasDoubleJumped = not is_on_floor()
	
	#quick fix for double jumping after falling of ledge
	if velocity.y == 0 and is_on_floor():
		hasDoubleJumped = false

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.y > gravity*1.5:
		fallen.emit()
	
	# Handle animations
	if direction and is_on_floor():
		$AnimatedSprite2D.play("run")
	elif  velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("idle")
	elif velocity.y != 0:
		if hasDoubleJumped:
			$AnimatedSprite2D.play("double jump")
		else :
			$AnimatedSprite2D.play("jump")

	move_and_slide()
