extends CanvasLayer

@onready var heartClass = preload("res://scenes/heart.tscn")


# Set maximum number of hearts
func setMaxHearts(maxHealth):
	for i in range(maxHealth):
		var heart = heartClass.instantiate()
		$HeartsContainer.add_child(heart)



# display current health in hearts
func updateHealth(currentHealth):
	var hearts = $HeartsContainer.get_children()
	
	for i in range(hearts.size()) :
		hearts[i].update(i < currentHealth)


# display updated score 
func updateScore(currentScore):
	$ScoreLable.text = str(currentScore).pad_zeros(4)
