extends ProgressBar

func _ready():
	value = Global2.SliderHP
	max_value = Global2.SliderHP

#Detect Enemies
func _on_Area2D_body_entered(body):
	if "Enemy_Large"in body.name:
		signalling()
	if "Enemy_Main"in body.name:
		signalling()
	if "Enemy_Bullet"in body.name:
		signalling()
	if "Enemy_Dodge"in body.name:
		signalling()
		
func signalling(): #Send Signal to Player
	emit_signal("changed")
	value -= 1


