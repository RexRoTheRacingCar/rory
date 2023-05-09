extends RigidBody2D


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_Area2D_body_entered(body):
	if "Enemy_Large" in body.name:
		queue_free()


