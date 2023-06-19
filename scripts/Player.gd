extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var maxHealth: int = 3

func _physics_process(delta):
	$Animation_Body.play("idle")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#
	# Your code goes here :)
	#

	move_and_slide()


#
# AND some here :P
#
