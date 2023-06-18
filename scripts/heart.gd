extends Panel


# Change Heart state depending on full
func update(full: bool):
	if full: $AnimatedSprite2D.frame = 0
	else: $AnimatedSprite2D.frame = 1
