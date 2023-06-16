extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update(full: bool):
	if full: $AnimatedSprite2D.frame = 0
	else: $AnimatedSprite2D.frame = 1
