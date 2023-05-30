extends ProgressBar

var HP = 7

#Detect Bullets
func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		emit_signal("changed")
		value -= 1
