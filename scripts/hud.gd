extends CanvasLayer

@onready var heartClass = preload("res://scenes/heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setMaxHearts(maxHealth):
	for i in range(maxHealth):
		var heart = heartClass.instantiate()
		$HeartsContainer.add_child(heart)
		
func updateHealth(currentHealth):
	var hearts = $HeartsContainer.get_children()
	
	for i in range(hearts.size()) :
		hearts[i].update(i < currentHealth)
