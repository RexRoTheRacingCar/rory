extends RigidBody2D


func _on_VisibilityNotifier2D_screen_exited(): #Delete when Off-Screen
	queue_free() 

func _on_Area2D_body_entered(body): #Delete when Detect Enemies
	if "Player" in body.name:
		queue_free()
	if "Title_Screen" in body.name:
		queue_free() 

