extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal hit
signal respawn
signal died
signal healthChanged
signal scoreChanged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hasDoubleJumped = false
var isHit = false

@export var maxHealth: int = 3
@onready var currentHealth: int = maxHealth
@onready var currentScore: int = 0


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("up") and (is_on_floor() or not hasDoubleJumped):
		velocity.y = JUMP_VELOCITY
		hasDoubleJumped = not is_on_floor()
		$Audio_Jump.play()
	
	#quick fix for double jumping after falling of ledge
	if velocity.y == 0 and is_on_floor():
		hasDoubleJumped = false
		
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$Animation_Body.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.y > gravity*1.5:
		hit.emit()
		respawn.emit()
	
	# Handle animations
	if isHit:
		$Animation_Body.play("hit")
	elif direction and is_on_floor():
		$Animation_Body.play("run")
	elif  velocity.x == 0 and is_on_floor():
		$Animation_Body.play("idle")
	elif velocity.y != 0:
		if hasDoubleJumped:
			$Animation_Body.play("double jump")
		else :
			$Animation_Body.play("jump")

	move_and_slide()


# Handle collision via Hitbox
func _on_hit_box_area_entered(area):
	print("Player hit by: " + area.get_parent().name)
	hit.emit()
	isHit = true


# Handle animation_finished signal
func _on_animation_body_animation_looped():
	if isHit:
		isHit = false


# Handle hit signal
func _on_hit():
	$Audio_Hit.play()
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth
		died.emit()
	healthChanged.emit(currentHealth)
	print("Health left: " + str(currentHealth))
