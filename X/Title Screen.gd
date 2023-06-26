extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://world.tscn")
	Global.points -= Global.points
	queue_free()
